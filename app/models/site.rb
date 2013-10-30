class Site < ActiveRecord::Base
  attr_accessible :options, :subdomain, :theme_id
  serialize :options, Hash
  has_many :pages
  belongs_to :theme
end
