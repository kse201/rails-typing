require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test 'profile display' do
    log_in_as(@user)
    get user_path(@user)

    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    # assert_match @user.scores.count.to_s, response.body

    # @user.scores.paginate(page: 1).each do |score|
      # assert_match score.content, response.body
    # end
  end
end
