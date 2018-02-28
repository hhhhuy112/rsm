class CreateStatusSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :status_steps do |t|
      t.references :step, foreign_key: true
      t.string :name
      t.string :code
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
