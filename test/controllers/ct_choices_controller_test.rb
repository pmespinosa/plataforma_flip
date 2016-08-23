require 'test_helper'

class CtChoicesControllerTest < ActionController::TestCase
  setup do
    @ct_choice = ct_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ct_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ct_choice" do
    assert_difference('CtChoice.count') do
      post :create, ct_choice: { ct_question_id: @ct_choice.ct_question_id, right: @ct_choice.right, text: @ct_choice.text }
    end

    assert_redirected_to ct_choice_path(assigns(:ct_choice))
  end

  test "should show ct_choice" do
    get :show, id: @ct_choice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ct_choice
    assert_response :success
  end

  test "should update ct_choice" do
    patch :update, id: @ct_choice, ct_choice: { ct_question_id: @ct_choice.ct_question_id, right: @ct_choice.right, text: @ct_choice.text }
    assert_redirected_to ct_choice_path(assigns(:ct_choice))
  end

  test "should destroy ct_choice" do
    assert_difference('CtChoice.count', -1) do
      delete :destroy, id: @ct_choice
    end

    assert_redirected_to ct_choices_path
  end
end
