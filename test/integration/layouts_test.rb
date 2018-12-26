require 'test_helper'

class LayoutsTest < ActionDispatch::IntegrationTest
	test 'layout links' do
		get root_path
		assert_template 'static/home'
		assert_select 'a[href=?]', root_path
		assert_select 'a[href=?]', about_path
		assert_select 'a[href=?]', developer_path
		assert_select 'a[href=?]', help_path
		assert_select 'a[href=?]', tutorial_path
	end
end
