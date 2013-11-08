class Block < ActiveRecord::Base
  attr_accessible :options, :sandbox_id, :name
  belongs_to :sandbox
  serialize :options, Hash

  def method_missing method_name
    if response = options[method_name]
      response
    else
      super
    end
  end

  def respond_to? method_name, include_all=false
    super || !!options[method_name]
  end

  def block_type
    self.class.to_s.underscore
  end
end
