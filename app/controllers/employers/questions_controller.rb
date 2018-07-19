class Employers::QuestionsController < Employers::EmployersController
  load_and_authorize_resource

  def index
    @questions = Question.get_newest.get_name params[:name_question]
    render partial: "question", locals: {questions: @questions}
  end
end
