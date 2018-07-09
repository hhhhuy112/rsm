class CreateSkillSets < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_sets do |t|
      t.references :interview_type, foreign_key: true
      t.references :skill, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
