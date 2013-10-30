class Theme < ActiveRecord::Base
  attr_accessible :name

  has_many :sites
end
