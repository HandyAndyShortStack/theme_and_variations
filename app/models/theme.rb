class Theme < ActiveRecord::Base
  attr_accessible :name, :uri, :styles, :javascripts, :images, :layout
  serialize :styles, Array
  serialize :javascripts, Array
  serialize :images, Array
  has_many :sites
  has_many :templates

  def sync theme_name, bucket
    return false unless bucket_list = get_bucket_list(theme_name, bucket)
    uri = "https://s3-us-west-2.amazonaws.com/#{bucket}/#{theme_name}"
    styles = get_files(bucket_list) { |file| file =~ /^assets\/.+\.css\.liquid$/ }
    styles.map! { |path| HTTParty.get("#{uri}/#{path}").body }
    javascripts = get_files(bucket_list) { |file| file =~ /^assets\/.+\.js$/ }
    images = get_files(bucket_list) { |file| file =~ /^assets\/.+\.(gif|jpg|jpeg|tiff|png)$/ }
    layout = HTTParty.get("#{uri}/layout/theme.liquid").body
    update_attributes({
      name:        theme_name,
      uri:         uri,
      styles:      styles,
      javascripts: javascripts,
      images:      images,
      layout:      layout
    })
    sync_templates(bucket_list)
    true
  end

  def drop
    ThemeDrop.new self
  end

private

  def get_bucket_list theme_name, bucket
    s3_uri = "http://#{bucket}.s3.amazonaws.com/?prefix=#{theme_name}/"
    response = HTTParty.get(s3_uri).parsed_response
    bucket_list = response["ListBucketResult"]["Contents"]
    return false if bucket_list.class != Array
    bucket_list.map! { |item| item["Key"].sub("#{theme_name}/", "") }
    bucket_list.delete_if { |item| item =~ /\/$/ || item.empty? }
    if %w(assets/style.css.liquid layout/theme.liquid templates/index.liquid).-(bucket_list).empty?
      bucket_list
    else
      false
    end
  end

  def get_files bucket_list, &block
    files = []
    bucket_list.each do |file|
      files << file if block.call(file)
    end
    files
  end

  def sync_templates bucket_list
    s3_templates = get_files(bucket_list) { |file| file =~ /^templates\/.+\.liquid$/ }
    s3_templates.each do |s3_template|
      hsh = { path: s3_template, liquid: HTTParty.get("#{self.uri}/#{s3_template}").body }
      if template = self.templates.find_by_path(s3_template)
        template.update_attributes(hsh)
      else
        self.templates.create(hsh)
      end
    end
  end
end
