require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @score = @user.scores.build(point: 100)
  end

  test 'should be valie' do
    assert @score.valid?
  end

  test 'user id should be presetn' do
    @score.user_id = nil
    assert_not @score.valid?
  end

  test 'score should be present' do
    @score.point = -1
    assert_not @score.valid?
  end

  test 'score should be at most 140 characters' do
    @score.point = 101
    assert_not @score.valid?
  end

  test 'order should be most recent first' do
    assert_equal scores(:most_recent), Score.first
  end
end
