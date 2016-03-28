class AddPtObjectToWebapp < ActiveRecord::Migration
  def change
    add_column :webapps, :ptobject, :text
  end
end
