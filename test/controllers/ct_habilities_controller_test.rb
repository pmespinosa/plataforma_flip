require 'test_helper'

class CtHabilitiesControllerTest < ActionController::TestCase
  setup do
    @ct_hability = ct_habilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ct_habilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ct_hability" do
    assert_difference('CtHability.count') do
      post :create, ct_hability: { description: @ct_hability.description, name: @ct_hability.name }
    end

    assert_redirected_to ct_hability_path(assigns(:ct_hability))
  end

  test "should show ct_hability" do
    get :show, id: @ct_hability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ct_hability
    assert_response :success
  end

  test "should update ct_hability" do
    patch :update, id: @ct_hability, ct_hability: { description: @ct_hability.description, name: @ct_hability.name }
    assert_redirected_to ct_hability_path(assigns(:ct_hability))
  end

  test "should destroy ct_hability" do
    assert_difference('CtHability.count', -1) do
      delete :destroy, id: @ct_hability
    end

    assert_redirected_to ct_habilities_path
  end
end
