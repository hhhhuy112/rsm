class CompanyStep < ApplicationRecord
  belongs_to :company
  belongs_to :step

  scope :search_company, ->company_id{where company_id: company_id}
  scope :priority_lowest, ->{order :priority}

  def load_step company, plus_number
    company_step = company.company_steps.includes(:step).find_by priority: self.priority + plus_number
    return if company_step.blank?
    company_step.step
  end

  def is_first_company_step?
    self.priority == Settings.priority.one
  end
end
