class StatusStep < ApplicationRecord
  belongs_to :step

  scope :load_by, -> code_text do
    where "code LIKE ?", "%#{code_text}%"
  end
  scope :search_step, ->step_id{where step_id: step_id}

  scope :get_status, -> status{where name: status}

  class << self
    def status_step_priority_company company_id
      company = CompanyStep.search_company company_id
      StatusStep.find_by(step_id: company.priority_lowest
        .first.step_id, code: Settings.first_status)&.id if company.present?
    end
  end

  def is_status? code
    self.code.include? code
  end
end
