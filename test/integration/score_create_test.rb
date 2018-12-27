require 'test_helper'

class ScoreCreateTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'score create' do
    log_in_as(@user)
    get root_path
  end

  test 'can not post score when not login' do
    post scores_path, params: {
      score: {
        point: 100
      }
    }

    assert_redirected_to login_path
  end

  test 'create score' do
    log_in_as(@user)
    assert_difference 'Score.count' do
      post scores_path, params: {
        score: {
          point: 100
        }
      }
    end
    assert Score.last.user == @user
  end
end
