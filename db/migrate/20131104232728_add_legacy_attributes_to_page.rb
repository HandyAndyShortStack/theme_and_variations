class AddLegacyAttributesToPage < ActiveRecord::Migration
  def change
    add_column :pages, :url, :string
    add_column :pages, :title, :string
  end
end
