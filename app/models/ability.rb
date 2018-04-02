class Ability
  include CanCan::Ability

  def initialize user, controller_namespace = nil
    return undefine_user if user.blank?
    case controller_namespace
    when "Employers"
      permission_employer user
    else
      if user.is_employer?
        permission_employer user
      end

      if user.admin?
        permission_admin
      end
      permission_user user
    end
  end

  private

  def permission_employer user
    return unless user.is_employer? || user.members.present?
    company = user.members.get_by_role(:employer).last.company
    manage_company user, company
  end

  def manage_company user, company
    can :update, Company, id: company.id
    can :manage, Member, company_id: company.id
    can :manage, Job, company_id: company.id
    can :manage, Appointment, company_id: company.id
    can :manage, Template, company_id: company.id
    can :create, Apply
    can :manage, Apply, job_id: company.jobs.pluck(:id)
    can :create, ApplyStatus
    can :read, Step
    can :manage, ApplyStatus, apply_id: company.applies.pluck(:id)
    can :read, StatusStep, company_id: company.id
    can :manage, Question, company_id: company.id
    can :manage, Note
    can :manage, :candidate do
      user.company_id == company.id
    end
  end

  def permission_admin
    can :manage, :all
  end

  def permission_user user
    can :read, :all
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
