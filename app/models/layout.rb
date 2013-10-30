class Layout < ActiveRecord::Base
  attr_accessible :html, :name, :theme_id
  belongs_to :theme
end
