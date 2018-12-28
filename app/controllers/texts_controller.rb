class TextsController < ApplicationController
  def index
    @texts = Text.game_set
    render json: @texts
  end
end
