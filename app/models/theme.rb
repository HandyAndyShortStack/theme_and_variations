class Theme < ActiveRecord::Base
  attr_accessible :name, :uri, :styles, :javascripts
  serialize :styles, Array
  serialize :javascripts, Array
  has_many :sites
  has_many :layouts
end
