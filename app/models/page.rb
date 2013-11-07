class Page < ActiveRecord::Base
  attr_accessible :template_id, :options, :site_id, :title, :url
  serialize :options, Hash
  has_many :sandboxes
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
    PageDrop.new self
  end
end
