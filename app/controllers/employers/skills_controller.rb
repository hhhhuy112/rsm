class Employers::SkillsController < Employers::EmployersController
  load_and_authorize_resource
  before_action :load_notifications, only: :index
  before_action :load_skills, only: %i(index destroy)
  before_action :load_type_skill, expect: %i(index show)

  def index; end

  def new; end

  def create
    respond_to do |format|
      if @skill.save
        load_skills
        format.js{@success = t "employers.skills.created_success"}
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @skill.update skill_params
        load_skills
        format.js{@success = t "employers.skills.updated_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if has_many_knowledges?
        format.js{@error = t "employers.skills.cant_destroy"}
      else
        if @skill.destroy
          load_skills
          format.js{@success = t "employers.skills.deleted_success"}
        else
          format.js{@error = t "employers.skills.deleted_fail"}
        end
      end
    end
  end

  private

  def skill_params
    params.require(:skill).permit :name, :type_skill
  end

  def load_skills
    @basic_skills = @company.skills.basic.includes(:knowledges).page(params[:page_basic_skill]).per Settings.skills.page
    @writing_skills = @company.skills.writing.includes(:knowledges).page(params[:page_writing_skill]).per Settings.skills.page
  end

  def has_many_knowledges?
    @skill.knowledges.present?
  end

  def load_type_skill
    @type_skills = Skill.type_skills
  end
end
