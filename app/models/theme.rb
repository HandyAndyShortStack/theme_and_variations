class Theme < ActiveRecord::Base
  attr_accessible :name, :uri, :styles, :javascripts, :images, :layout
  serialize :styles, Array
  serialize :javascripts, Array
  serialize :images, Array
  has_many :sites
end
