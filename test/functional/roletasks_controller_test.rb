require 'test_helper'

class RoletasksControllerTest < ActionController::TestCase
  setup do
    @roletask = roletasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roletasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create roletask" do
    assert_difference('Roletask.count') do
      post :create, roletask: @roletask.attributes
    end

    assert_redirected_to roletask_path(assigns(:roletask))
  end

  test "should show roletask" do
    get :show, id: @roletask.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @roletask.to_param
    assert_response :success
  end

  test "should update roletask" do
    put :update, id: @roletask.to_param, roletask: @roletask.attributes
    assert_redirected_to roletask_path(assigns(:roletask))
  end

  test "should destroy roletask" do
    assert_difference('Roletask.count', -1) do
      delete :destroy, id: @roletask.to_param
    end

    assert_redirected_to roletasks_path
  end
end
