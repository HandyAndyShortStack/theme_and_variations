class Page < ActiveRecord::Base
  attr_accessible :layout_id, :options, :site_id
  serialize :options, Hash
  belongs_to :layout
  belongs_to :site
end
