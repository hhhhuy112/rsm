class Employers::SkillSetsController < Employers::EmployersController
  before_action :load_interview_type, only: %i(new create)
  before_action :build_skill_set, only: :new
  before_action :build_skill_sets, only: :create
  load_and_authorize_resource

  def new
    respond_to :js
  end

  def create
    respond_to do |format|
      if params[:type] == Settings.interview_type.add_skill_type.exists
        import_skill_sets
      else
        add_new_skill
      end
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @skill_set.destroy
        format.js{@success = t "employers.interview_types.destroy_success"}
      else
        format.js{@error = t "employers.interview_types.destroy_fail"}
      end
    end
  end

  private

  def skill_set_params
    params.require(:skill_set).permit :interview_type_id,
      skill_attributes: [:name, :company_id, :type_skill]
  end

  def add_new_skill
    skill_set = SkillSet.new skill_set_params
    if skill_set.save
      load_skill_sets
      @success = t "employers.interview_types.add_skill_success"
    else
      @error = t "employers.interview_types.add_skill_fail"
    end
  end

  def load_interview_type
    interview_type_id = params[:interview_type_id] || params[:skill_set][:interview_type_id]
    @interview_type = InterviewType.find_by id: interview_type_id
    return if @interview_type
    error_message = t "not_found", error_message: t("employers.evaluations.interview_type")
    render js: "alertify.error('#{error_message}')"
  end

  def build_skill_sets
    @skill_sets = []
    skill_ids.map do |skill_id|
      @skill_sets << @interview_type.skill_sets.build(skill_id: skill_id)
    end
  end

  def skill_ids
    return [] if params[:skill_id].blank?
    ids = []
    params[:skill_id].map do |id|
      next if id.blank?
      ids << id.to_i
    end
    ids - @interview_type.skills.ids
  end

  def load_skill_sets
    @skill_sets = SkillSet.of_interview_type(@interview_type.id).includes :skill
  end

  def build_skill_set
    @skill_set = @interview_type.skill_sets.build
  end

  def import_skill_sets
    result = SkillSet.import @skill_sets
    unless result.num_inserts.zero?
      load_skill_sets
      @success = t "employers.interview_types.add_skill_success"
    else
      @error = t "employers.interview_types.add_skill_fail"
    end
  end
end
