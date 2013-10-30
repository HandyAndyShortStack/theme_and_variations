class CreateContentAreas < ActiveRecord::Migration
  def change
    create_table :content_areas do |t|
      t.integer :page_id

      t.timestamps
    end
  end
end
