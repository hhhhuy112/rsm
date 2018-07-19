class Employers::InterviewTypesController < Employers::EmployersController
  before_action :build_interview_type, only: :new
  load_and_authorize_resource
  before_action :load_interview_types, only: :index
  before_action :build_skill_sets, only: :create

  def index; end

  def new
    respond_to do |format|
      format.js
      format.html{redirect_to employers_interview_types_path}
    end
  end

  def create
    InterviewType.transaction requires_new: true do
      respond_to do |format|
        if @interview_type.save
          SkillSet.import @skill_sets if @skill_sets.present?
          format.js{@success = t "employers.interview_types.add_success"}
        else
          raise ActiveRecord::Rollback
          format.js{@error = t "employers.interview_types.add_fail"}
        end
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
      format.html{redirect_to employers_interview_types_path}
    end
  end

  def update
    respond_to do |format|
      if @interview_type.update interview_type_params
        format.js{@success = t "employers.interview_types.update_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @interview_type.destroy
        format.js{@success = t "employers.interview_types.destroy_success"}
      else
        format.js{@error = t "employers.interview_types.destroy_fail"}
      end
    end
  end

  private

  def interview_type_params
    params.require(:interview_type).permit :id, :name, :company_id,
      skill_sets_attributes: [skill_attributes: [:name, :company_id, :type_skill]]
  end

  def load_interview_types
    @interview_types = @company.interview_types.includes :skill_sets, :skills
  end

  def build_interview_type
    @interview_type = @company.interview_types.build
    @interview_type.skill_sets.build
  end

  def build_skill_sets
    return if params[:skill_id].blank?
    @skill_sets = []
    params[:skill_id].map do |skill_id|
      next if skill_id.blank?
      @skill_sets << @interview_type.skill_sets.build(skill_id: skill_id)
    end
  end
end
