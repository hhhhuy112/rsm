class Employers::TemplatesController < Employers::EmployersController
  before_action :load_templates, only: :index
  before_action :load_type_template, expect: %i(index)
  before_action :load_currency, only: :show, unless: :is_template_benefit?

  def index; end

  def new;end

  def create
    respond_to do |format|
      if @template.save
        format.js{@message = t"employers.template.create_success"}
        load_templates
      else
        load_type_template
        format.js
      end
    end
  end

  def show
    if is_template_benefit?
      render json: {data: @template.template_body}
    else
      @information = {name: params[:name], address: params[:address],
        start_time: params[:start_time], end_time: params[:end_time],
        salary: params[:salary], offer_address: params[:offer_address],
        requirement: params[:requirement], date_offer: params[:date_offer]}
      @information[:currency_unit] = @currency ? @currency.sign : nil
      respond_to :js
    end
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
    @interviewers = Template.template_member.get_newest.page(params[:page])
      .per Settings.templates.page
    @candidates = Template.template_user.get_newest.page(params[:page])
      .per Settings.templates.page
    @benefits = @company.templates.template_benefit.get_newest.page(params[:page])
      .per Settings.templates.page
    @page = params[:page]
  end

  def load_type_template
    @type_template = Template.type_ofs
  end

  def load_currency
    @currency = Currency.find_by id: params[:currency_id]
  end

  def is_template_benefit?
    params[:is_benefit].present?
  end
end

