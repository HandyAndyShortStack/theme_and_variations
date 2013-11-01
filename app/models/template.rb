class Template < ActiveRecord::Base
  attr_accessible :liquid, :theme_id, :path
  has_many :pages
  belongs_to :theme
end
