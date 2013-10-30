class Site < ActiveRecord::Base
  attr_accessible :options, :subdomain, :theme_id
end
