class CreateSandboxes < ActiveRecord::Migration
  def change
    create_table :sandboxes do |t|
      t.integer :page_id

      t.timestamps
    end
  end
end
