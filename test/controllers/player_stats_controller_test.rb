require "test_helper"

class PlayerStatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get player_stats_index_url
    assert_response :success
  end
end
