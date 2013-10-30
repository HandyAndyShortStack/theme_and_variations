class Page < ActiveRecord::Base
  attr_accessible :layout_id, :options, :site_id
  serialize :options, Hash
  has_many :content_areas
  belongs_to :layout
  belongs_to :site
end
