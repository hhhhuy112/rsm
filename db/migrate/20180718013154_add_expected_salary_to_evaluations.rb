class AddExpectedSalaryToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_column :evaluations, :expected_salary, :float
    add_column :evaluations, :start_date, :datetime
    add_reference :evaluations, :currency, foreign_key: true
  end
end
