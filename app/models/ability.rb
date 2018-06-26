class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil, apply = nil
    return undefine_user if user.blank?
    case controller_namespace
    when "Employers"
      permission_employer user, apply
    else
<<<<<<< 2e3dae3266e8c9697d022303e7c512d98f225c12
      permission_user user
      if user.employer?
=======
      permission_user user, apply
      if user.is_employer?
>>>>>>> manage interviews
        permission_employer user
      end

      if user.admin?
        permission_admin
      end
    end
  end

  private

<<<<<<< 2e3dae3266e8c9697d022303e7c512d98f225c12
  def permission_employer user
    return unless user.employer?
    company = user.company
=======
  def permission_employer user, apply
    return unless user.is_employer? || user.members.present?
    company = user.members.get_by_role(:employer).last.company
>>>>>>> manage interviews
    manage_company user, company
    return if user.inforappointments.blank?
    manage_interview user, company, apply
  end

  def manage_company user, company
    can :read, User, company_id: company.id
    can :update, Company, id: company.id
    can :manage, Member, company_id: company.id
    can :manage, Job, company_id: company.id
    can :manage, Appointment, company_id: company.id
    can :manage, Template, company_id: company.id
    can :create, Apply
    can :manage, Apply, job_id: company.job_ids
    can :read, Step
    can :create, ApplyStatus
    can :manage, ApplyStatus, apply_id: company.apply_ids
    can :read, StatusStep
    can :manage, Question, company_id: company.id
    can %i(read create), Note
    can %i(update destroy), Note, user_id: user.id
    can :manage, :candidate if user.company_id == company.id
    can :manage, :dashboard if user.company_id == company.id
    can :manage, :send_email if user.company_id == company.id
    can :manage, :email_google if user.company_id == company.id
    can :manage, Skill, company_id: company.id
    can :read, Evaluation, apply_id: company.apply_ids
    can :read, Knowledge, skill_id: company.skill_ids
  end

  def manage_interview user, company, apply
    can :create, Evaluation, apply_id: apply.id if apply.present? &&  user.apply_interview_ids.include?(apply.id)
    can :manage, Evaluation, apply_id: Evaluation.apply_ids(user.evaluations)
    can :create, Knowledge
    can :manage, Knowledge, skill_id: Evaluation.skill_ids(user.evaluations)
    can :manage, :interview if user.company_id == company.id
  end

  def permission_admin
    can :manage, :all
  end

  def permission_user user
    can :read, :all, id: user.id
    can :update, User, id: user.id
    can :manage, Club, user_id: user.id
    can :manage, Achievement, user_id: user.id
    can :manage, Certificate, user_id: user.id
    can :manage, Experience, user_id: user.id
    can :manage, BookmarkLike, user_id: user.id
    can :create, Apply
  end

  def undefine_user
    can :create, Apply
    can :read, :all
  end
end
