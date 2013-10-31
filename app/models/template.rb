class Template < ActiveRecord::Base
  attr_accessible :liquid, :theme_id
  has_many :pages
  belongs_to :theme
end
