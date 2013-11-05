class Site < ActiveRecord::Base
  attr_accessible :options, :subdomain, :theme_id
  serialize :options, Hash
  has_many :pages
  belongs_to :theme

  def method_missing method_name
    if response = options[method_name]
      response
    else
      super
    end
  end

  def respond_to? method_name, include_all=false
    super || !!options[method_name]
  end

  def drop
    Site::Drop.new self
  end

  class Drop < Liquid::Drop
    
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
  end
end
