class CreateRewardBenefits < ActiveRecord::Migration[5.1]
  def change
    create_table :reward_benefits do |t|
      t.text :content
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
