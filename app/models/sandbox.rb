class Sandbox < ActiveRecord::Base
  attr_accessible :page_id
  has_many :blocks
  belongs_to :page
end
