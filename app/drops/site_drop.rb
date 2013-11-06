class SiteDrop < Liquid::Drop
  
  def initialize site
    @site = site
  end

  method_names = [
    :title,
    :meta_tags,
    :custom_css,
    :custom_url,
    :closing_tag,
    :gac,
    :gwt,
    :description,
    :subdomain
  ]

  method_names.each do |method_name|
    define_method method_name do
      @site.send method_name if @site.respond_to? method_name
    end
  end

  def pages
    @site.pages.map { |page| page.drop }
  end
end
