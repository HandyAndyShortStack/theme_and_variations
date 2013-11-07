class Sandbox < ActiveRecord::Base
  attr_accessible :page_id
  has_many :blocks
  belongs_to :page

  def render
    ActionView::Base.new(Rails.configuration.paths["app/views"]).render({
      partial: "sandbox/layout",
      format: :txt, 
      locals:  { 
        sandbox: self
      }
    })
  end
end
