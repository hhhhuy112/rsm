class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :name
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
