class CreateKnowledges < ActiveRecord::Migration[5.2]
  def change
    create_table :knowledges do |t|
      t.references :evaluation, foreign_key: true
      t.references :skill, foreign_key: true
      t.integer :score, default: 0
      t.text :note
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
