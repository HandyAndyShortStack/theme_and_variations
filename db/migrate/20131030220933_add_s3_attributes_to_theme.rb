class AddS3AttributesToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :uri, :string
    add_column :themes, :styles, :text
    add_column :themes, :javascripts, :text
  end
end
