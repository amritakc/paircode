class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :alias
      t.string :email
      t.string :password_digest
      t.string :street
      t.string :city
      t.string :state
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
