class AddAppIdIndexToWebapp < ActiveRecord::Migration
  def change
    add_index :webapps, :appid
  end
end
