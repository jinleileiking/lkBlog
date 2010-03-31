require 'test_helper'

class PagecontentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagecontents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagecontent" do
    assert_difference('Pagecontent.count') do
      post :create, :pagecontent => { }
    end

    assert_redirected_to pagecontent_path(assigns(:pagecontent))
  end

  test "should show pagecontent" do
    get :show, :id => pagecontents(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pagecontents(:one).to_param
    assert_response :success
  end

  test "should update pagecontent" do
    put :update, :id => pagecontents(:one).to_param, :pagecontent => { }
    assert_redirected_to pagecontent_path(assigns(:pagecontent))
  end

  test "should destroy pagecontent" do
    assert_difference('Pagecontent.count', -1) do
      delete :destroy, :id => pagecontents(:one).to_param
    end

    assert_redirected_to pagecontents_path
  end
end
