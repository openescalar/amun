require 'test_helper'

class LoadbalancersControllerTest < ActionController::TestCase
  setup do
    @loadbalancer = loadbalancers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:loadbalancers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create loadbalancer" do
    assert_difference('Loadbalancer.count') do
      post :create, loadbalancer: @loadbalancer.attributes
    end

    assert_redirected_to loadbalancer_path(assigns(:loadbalancer))
  end

  test "should show loadbalancer" do
    get :show, id: @loadbalancer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @loadbalancer.to_param
    assert_response :success
  end

  test "should update loadbalancer" do
    put :update, id: @loadbalancer.to_param, loadbalancer: @loadbalancer.attributes
    assert_redirected_to loadbalancer_path(assigns(:loadbalancer))
  end

  test "should destroy loadbalancer" do
    assert_difference('Loadbalancer.count', -1) do
      delete :destroy, id: @loadbalancer.to_param
    end

    assert_redirected_to loadbalancers_path
  end
end
