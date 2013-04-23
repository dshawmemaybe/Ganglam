require 'test_helper'

class TestudosControllerTest < ActionController::TestCase
  setup do
    @testudo = testudos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:testudos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create testudo" do
    assert_difference('Testudo.count') do
      post :create, testudo: { name: @testudo.name }
    end

    assert_redirected_to testudo_path(assigns(:testudo))
  end

  test "should show testudo" do
    get :show, id: @testudo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @testudo
    assert_response :success
  end

  test "should update testudo" do
    put :update, id: @testudo, testudo: { name: @testudo.name }
    assert_redirected_to testudo_path(assigns(:testudo))
  end

  test "should destroy testudo" do
    assert_difference('Testudo.count', -1) do
      delete :destroy, id: @testudo
    end

    assert_redirected_to testudos_path
  end
end
