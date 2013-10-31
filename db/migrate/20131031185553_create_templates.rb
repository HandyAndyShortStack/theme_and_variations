class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :theme_id
      t.text :liquid

      t.timestamps
    end
  end
end
