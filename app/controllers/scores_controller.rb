class ScoresController < ApplicationController
  before_action :logged_in_user, only: %i[create]

  def create
    @score = current_user.scores.build(score_params)
    if @score.save
      flash[:success] = 'Score created'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  private

  def score_params
    params.require(:score).permit(:point)
  end
end
