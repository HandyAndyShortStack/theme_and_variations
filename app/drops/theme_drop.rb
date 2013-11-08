class ThemeDrop < Liquid::Drop

  def initialize theme
    @theme = theme
  end

  method_names = [
    :javascripts,
    :images
  ]

  method_names.each do |method_name|
    define_method method_name do
      @theme.send(method_name).map { |item| "#{@theme.uri}/#{item}" }
    end
  end

  def styles
    @theme.styles.map { |style| Liquid::Template.parse(style).render({}, filters: [filter_module]) }
  end

  def filter_module theme=@theme
    Module.new do
      define_method :asset_url do |input|
        "#{theme.uri}/assets/#{input}"
      end
    end
  end
end
