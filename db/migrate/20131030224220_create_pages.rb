class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :layout_id
      t.integer :site_id
      t.text :options

      t.timestamps
    end
  end
end
