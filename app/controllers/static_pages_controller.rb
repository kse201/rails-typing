class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def contact
  end

  def about
  end

  def ranking
    @top_record = Score.top_record.paginate(page: params[:page], per_page: 10)
  end
end
