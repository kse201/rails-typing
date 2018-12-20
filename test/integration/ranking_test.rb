require 'test_helper'

class RankingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'show top 10 ranker' do
    log_in_as @user

    get ranking_path
    records = Score.top_record(10)
    assert_template 'static_pages/ranking'

    records.each do |record|
      assert_select 'a[href=?]', user_path(record.user), count: 1
    end
  end
end
