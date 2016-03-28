class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :code
      t.text :desc

      t.timestamps null: false
    end
  end
end
