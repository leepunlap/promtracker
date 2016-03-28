class CreateWebapps < ActiveRecord::Migration
  def change
    create_table :webapps do |t|
      t.integer :organization_id
      t.string :name
      t.text :desc
      t.string :appid
      t.string :appsecret

      t.timestamps null: false
    end
  end
end
