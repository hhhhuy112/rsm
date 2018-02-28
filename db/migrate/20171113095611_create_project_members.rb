class CreateProjectMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_members do |t|
      t.boolean :status
      t.references :member, foreign_key: true
      t.references :project, foreign_key: true
      t.index [:member_id, :project_id], unique: true

      t.timestamps
    end
  end
end
