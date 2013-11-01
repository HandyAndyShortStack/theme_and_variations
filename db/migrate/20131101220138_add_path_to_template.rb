class AddPathToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :path, :string
  end
end
