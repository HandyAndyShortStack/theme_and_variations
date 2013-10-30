class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.text :html
      t.integer :theme_id
      t.string :name

      t.timestamps
    end
  end
end
