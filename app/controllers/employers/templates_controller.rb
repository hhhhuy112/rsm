class Employers::TemplatesController < ApplicationController
  def show
    @template = Template.find_by id: params[:id]
    @apply = params[:apply]
  end
end
