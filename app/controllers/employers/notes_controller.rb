class Employers::NotesController < Employers::EmployersController
  load_and_authorize_resource
  before_action :load_apply, except: :destroy

  def new
    @note = current_user.notes.build apply_id: @apply.id
  end

  def create
    if @note.save
      load_notes
      @success = t ".success"
    end
  end

  def edit; end

  def update
    if @note.update_attributes note_params
      @success = t ".updated_success"
    end
  end

  def destroy
    if @note.destroy
      @success = t ".destroyed_success"
    end
  end

  private

  def note_params
    params.require(:note).permit :content, :user_id, :apply_id
  end

  def load_apply
    @apply = Apply.find_by id: params[:apply_id]
    return if @apply
    @error = t ".not_found_apply"
  end
end
