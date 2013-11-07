class Block < ActiveRecord::Base
  attr_accessible :options, :sandbox_id
  belongs_to :sandbox
  serialize :options, Hash
end
