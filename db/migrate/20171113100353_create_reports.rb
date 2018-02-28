class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :type
      t.text :reason
      t.integer :reporter_id
      t.integer :reported_id

      t.timestamps
    end
    add_index :reports, :reporter_id
    add_index :reports, :reported_id
  end
end
