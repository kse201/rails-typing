require 'test_helper'

class ScoreCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'score create' do
    log_in_as(@user)
    get root_path

  end
end
