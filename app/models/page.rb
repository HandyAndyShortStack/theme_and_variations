class Page < ActiveRecord::Base
  attr_accessible :template_id, :options, :site_id
  serialize :options, Hash
  has_many :content_areas
  belongs_to :template
  belongs_to :site
end
