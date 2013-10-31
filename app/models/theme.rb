class Theme < ActiveRecord::Base
  attr_accessible :name, :uri, :styles, :javascripts, :images, :layout
  serialize :styles, Array
  serialize :javascripts, Array
  serialize :images, Array
  has_many :sites

  def sync location
    return false unless responses = get_responses(location)
    name = URI(location).path.split('/').last
    update_attributes({
      name: name,
      uri:  location
    })
  end

private
  
  def get_responses location
    responses = {
      layout: HTTParty.get(location + "/layout/layout.liquid"),
      style:  HTTParty.get(location + "/assets/style.css"),
      index:  HTTParty.get(location + "/templates/index.liquid"),
    }
    success = true
    responses.each do |key, value|
      success = false unless value.code == 200
    end
    if success
      responses
    else
      false
    end
  end
end
