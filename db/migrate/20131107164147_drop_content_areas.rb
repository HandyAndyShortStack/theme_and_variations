class DropContentAreas < ActiveRecord::Migration
  def change
    drop_table :content_areas
  end
end
