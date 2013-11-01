class Theme < ActiveRecord::Base
  attr_accessible :name, :uri, :styles, :javascripts, :images, :layout
  serialize :styles, Array
  serialize :javascripts, Array
  serialize :images, Array
  has_many :sites

  def sync theme_name, bucket
    return false unless bucket_list = get_bucket_list(theme_name, bucket)
    update_attributes({
      name: theme_name
    })
  end

private
  
  def get_bucket_list theme_name, bucket
    s3_uri = "http://#{bucket}.s3.amazonaws.com/?prefix=#{theme_name}/"
    response = HTTParty.get(s3_uri).parsed_response
    bucket_list = response["ListBucketResult"]["Contents"]
    bucket_list.map! { |item| item["Key"].sub("#{theme_name}/", "") }
    bucket_list.delete_if { |item| item =~ /\/$/ || item.empty? }
    if %w(assets/style.css.liquid layout/theme.liquid templates/index.liquid).-(bucket_list).empty?
      bucket_list
    else
      false
    end
  end
end
