class ContentArea < ActiveRecord::Base
  attr_accessible :page_id
  belongs_to :page
end
