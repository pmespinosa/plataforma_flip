require 'test_helper'

class CtSubhabilitiesControllerTest < ActionController::TestCase
  setup do
    @ct_subhability = ct_subhabilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ct_subhabilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ct_subhability" do
    assert_difference('CtSubhability.count') do
      post :create, ct_subhability: { ct_hability_id: @ct_subhability.ct_hability_id, description: @ct_subhability.description, name: @ct_subhability.name }
    end

    assert_redirected_to ct_subhability_path(assigns(:ct_subhability))
  end

  test "should show ct_subhability" do
    get :show, id: @ct_subhability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ct_subhability
    assert_response :success
  end

  test "should update ct_subhability" do
    patch :update, id: @ct_subhability, ct_subhability: { ct_hability_id: @ct_subhability.ct_hability_id, description: @ct_subhability.description, name: @ct_subhability.name }
    assert_redirected_to ct_subhability_path(assigns(:ct_subhability))
  end

  test "should destroy ct_subhability" do
    assert_difference('CtSubhability.count', -1) do
      delete :destroy, id: @ct_subhability
    end

    assert_redirected_to ct_subhabilities_path
  end
end
