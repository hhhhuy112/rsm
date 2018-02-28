class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :apply
      t.references :survey
      t.text :name

      t.timestamps
    end
  end
end
