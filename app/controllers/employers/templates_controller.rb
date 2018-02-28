class Employers::TemplatesController < Employers::EmployersController
  before_action :load_templates, only: %i(index create)
  before_action :load_type_template, expect: %i(index)

  def index; end

  def new;end

  def create
    respond_to do |format|
      if @template.save
        format.js{@message = t"employers.template.create_success"}
      else
        @type_template = Template.type_ofs
        format.js
      end
    end
  end

  def show
    @information = {name: params[:name], address: params[:address],
      start_time: params[:start_time], end_time: params[:end_time],
      salary: params[:salary], offer_address: params[:offer_address],
      requirement: params[:requirement], date_offer: params[:date_offer]}
    @template = Template.find_by id: params[:id]
    respond_to :js
  end

  def update
    respond_to do |format|
      if @template.update_attributes template_params
        load_templates
        format.js{@message = t ".update"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @template.destroy
        load_templates
        format.js{@message = t ".destroy"}
      else
        format.js
      end
    end
  end

  private

  def template_params
    params.require(:template).permit :name, :user_id, :template_body, :type_of, :title
  end

  def load_templates
    @interviewers = Template.template_member.page(params[:page]).per Settings.templates.page
    @candidates = Template.template_user.page(params[:page]).per Settings.templates.page
    @page = params[:page]
  end

  def load_type_template
    @type_template = Template.type_ofs
  end
end

