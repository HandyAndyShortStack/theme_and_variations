class PageDrop < Liquid::Drop
  
  def initialize page
    @page = page
  end

  method_names = [
    :title,
    :url
  ]

  method_names.each do |method_name|
    define_method method_name do
      @page.send method_name if @page.respond_to? method_name
    end
  end
end
