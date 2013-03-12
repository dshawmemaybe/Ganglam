require 'test_helper'

class AllschedulesControllerTest < ActionController::TestCase
  setup do
    @allschedule = allschedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:allschedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create allschedule" do
    assert_difference('Allschedule.count') do
      post :create, allschedule: @allschedule.attributes
    end

    assert_redirected_to allschedule_path(assigns(:allschedule))
  end

  test "should show allschedule" do
    get :show, id: @allschedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @allschedule
    assert_response :success
  end

  test "should update allschedule" do
    put :update, id: @allschedule, allschedule: @allschedule.attributes
    assert_redirected_to allschedule_path(assigns(:allschedule))
  end

  test "should destroy allschedule" do
    assert_difference('Allschedule.count', -1) do
      delete :destroy, id: @allschedule
    end

    assert_redirected_to allschedules_path
  end
end
