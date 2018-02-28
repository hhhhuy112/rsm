class Employers::QuestionsController < Employers::EmployersController
  def index
    @questions = Question.get_newest.get_name params[:name_question]
    render partial: "question", locals: {questions: @questions}
  end
end
