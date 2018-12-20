require 'test_helper'

class ScoresControllerTest < ActionDispatch::IntegrationTest
  def setup
    @score = scores(:one)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Score.count' do
      post scores_path, params: {
        score: {
          point: 100
        }
      }
    end
    assert_redirected_to login_url
  end

  test 'should create when logged in as own user' do
    assert_difference 'Score.count' do
      log_in_as(users(:michael))
      post scores_path, params: {
        score: {
          point: 100
        }
      }
    end
  end
end
