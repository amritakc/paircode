class CreateNinjas < ActiveRecord::Migration
  def change
    create_table :ninjas do |t|
      t.references :user, index: true
      t.references :language, index: true

      t.timestamps
    end
  end
end
