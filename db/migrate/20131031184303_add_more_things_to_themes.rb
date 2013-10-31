class AddMoreThingsToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :layout, :text
    add_column :themes, :images, :text
  end
end
