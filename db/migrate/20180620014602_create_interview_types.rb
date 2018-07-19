class CreateInterviewTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :interview_types do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
