class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :apply, foreign_key: true
      t.text :other
      t.datetime :deleted_at

      t.timestamps
    end
  end
end