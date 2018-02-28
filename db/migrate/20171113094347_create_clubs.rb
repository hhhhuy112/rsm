class CreateClubs < ActiveRecord::Migration[5.1]
  def change
    create_table :clubs do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :clubs, :name
  end
end
