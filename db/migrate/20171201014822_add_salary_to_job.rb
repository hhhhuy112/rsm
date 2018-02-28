class AddSalaryToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :min_salary, :float
    add_column :jobs, :max_salary, :float
  end
end
