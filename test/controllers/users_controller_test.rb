require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @non_activated_user = users(:non_active)
  end
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should not allow show non-activated user' do
    log_in_as(@user)
    get user_path(@non_activated_user)
    assert_redirected_to root_url
  end

  test 'should allow show activated user' do
    log_in_as(@user)
    get user_path(@other_user)
    assert_template 'users/show'
  end

  test 'should not allow the admin attribute to be edited via the web' do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: {
        password: 'password',
        password_confirmation: 'password',
        admin: true
      }
    }
    assert_not @other_user.admin?
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when logged in as a non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end

    assert_redirected_to root_url
  end

  test 'should destroy when logged in as a own-user' do
    log_in_as(@user)

    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end
end
