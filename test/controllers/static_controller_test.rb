require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  def setup
    @app_title = "Kalendarize"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@app_title}"
  end

  test "should get developer" do
    get developer_path
    assert_response :success
    assert_select "title", "Developer | #{@app_title}"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@app_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@app_title}"
  end

  test "should get tutorial" do
    get tutorial_path
    assert_response :success
    assert_select "title", "Tutorial | #{@app_title}"
  end
end
