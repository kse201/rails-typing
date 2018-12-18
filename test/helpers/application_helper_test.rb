require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title,         'Rails Typing'
    assert_equal full_title('Help'), 'Rails Typing | Help'
  end
end

