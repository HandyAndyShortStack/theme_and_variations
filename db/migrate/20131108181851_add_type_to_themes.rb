class AddTypeToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :type, :string
  end
end
