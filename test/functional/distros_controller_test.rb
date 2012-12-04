require 'test_helper'

class DistrosControllerTest < ActionController::TestCase
  setup do
    @distro = distros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distro" do
    assert_difference('Distro.count') do
      post :create, distro: @distro.attributes
    end

    assert_redirected_to distro_path(assigns(:distro))
  end

  test "should show distro" do
    get :show, id: @distro.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distro.to_param
    assert_response :success
  end

  test "should update distro" do
    put :update, id: @distro.to_param, distro: @distro.attributes
    assert_redirected_to distro_path(assigns(:distro))
  end

  test "should destroy distro" do
    assert_difference('Distro.count', -1) do
      delete :destroy, id: @distro.to_param
    end

    assert_redirected_to distros_path
  end
end
