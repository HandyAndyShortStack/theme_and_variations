class TestingTheme < Theme

  def templates
    current_templates = get_files(get_file_list("templates")) { |file| file =~ /\.liquid$/ }
    super.each do |template|
      template.destroy unless current_templates.include? "#{template.name}.liquid"
    end
    current_templates.each do |file_name|
      path = "templates/#{file_name}"
      liquid = File.open("#{theme_directory}/templates/#{file_name}").read
      template = super.find_by_path(path) || super.create
      template.update_attributes(path: path, liquid: liquid)
    end
    super
  end

  def layout
    File.open("#{theme_directory}/layout/theme.liquid").read
  end

  def styles
    file_list = get_file_list("assets")
    get_files(file_list) { |file| file =~ /\.css\.liquid$/ }.map do |file|
      File.open("#{theme_directory}/assets/#{file}").read
    end
  end

  def javascripts
    get_files(get_file_list("assets")) { |file| file =~ /\.js$/ }.map do |file|
      "assets/" << file
    end
  end

  def images
    get_files(get_file_list("assets")) { |file| file =~ /\.(gif|jpg|jpeg|tiff|png)$/ }
  end

private

  def theme_directory
    Rails.root.to_s << "/themes/#{self.name}"
  end

  def get_file_list path
    Dir.entries("#{Rails.root.to_s}/themes/#{self.name}/#{path}")
  end
end
