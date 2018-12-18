class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test 'user can delete acount when edit page and redirect root page' do
    log_in_as(@non_admin)
    get edit_user_path(@non_admin)
    assert_select 'a[href=?]', user_path(@non_admin), text: 'Delete this acount'

    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end

    assert_redirected_to root_path
  end
end
