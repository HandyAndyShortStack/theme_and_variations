class Block < ActiveRecord::Base
  attr_accessible :options, :sandbox_id
  belongs_to :sandbox
  serialize :options, Hash

  def render
    ActionView::Base.new(Rails.configuration.paths["app/views"]).render({
      partial: 'blocks/layout',
      format: :txt, 
      locals:  { 
        block: self
      }
    })
  end
end
