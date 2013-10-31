class ChangePageBelongsTo < ActiveRecord::Migration
  def up
    remove_column :pages, :layout_id
    add_column :pages, :template_id, :integer
  end

  def down
    remove_column :pages, :template_id
    add_column :pages, :layout_id, :integer
  end
end
