class Page < ActiveRecord::Base
  attr_accessible :template_id, :options, :site_id, :title, :url
  serialize :options, Hash
  has_many :content_areas
  belongs_to :template
  belongs_to :site

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
    Page::Drop.new self
  end

  class Drop < Liquid::Drop
    
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
end
