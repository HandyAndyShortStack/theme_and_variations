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
    SiteDrop.new self
  end
end
