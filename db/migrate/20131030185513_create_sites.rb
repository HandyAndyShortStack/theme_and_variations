class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.integer :theme_id
      t.text :options

      t.timestamps
    end
  end
end
