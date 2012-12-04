require 'test_helper'

class VpnsControllerTest < ActionController::TestCase
  setup do
    @vpn = vpns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vpns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vpn" do
    assert_difference('Vpn.count') do
      post :create, vpn: @vpn.attributes
    end

    assert_redirected_to vpn_path(assigns(:vpn))
  end

  test "should show vpn" do
    get :show, id: @vpn.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vpn.to_param
    assert_response :success
  end

  test "should update vpn" do
    put :update, id: @vpn.to_param, vpn: @vpn.attributes
    assert_redirected_to vpn_path(assigns(:vpn))
  end

  test "should destroy vpn" do
    assert_difference('Vpn.count', -1) do
      delete :destroy, id: @vpn.to_param
    end

    assert_redirected_to vpns_path
  end
end
