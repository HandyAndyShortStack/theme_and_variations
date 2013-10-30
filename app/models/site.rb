class Site < ActiveRecord::Base
  attr_accessible :options, :subdomain, :theme_id

  belongs_to :theme
end
