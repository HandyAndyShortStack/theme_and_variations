class AddNameToSandboxes < ActiveRecord::Migration
  def change
    add_column :sandboxes, :name, :string
  end
end
