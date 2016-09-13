require 'test_helper'

class ContentChoicesControllerTest < ActionController::TestCase
  setup do
    @content_choice = content_choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_choice" do
    assert_difference('ContentChoice.count') do
      post :create, content_choice: { content_question_id: @content_choice.content_question_id, right: @content_choice.right, text: @content_choice.text }
    end

    assert_redirected_to content_choice_path(assigns(:content_choice))
  end

  test "should show content_choice" do
    get :show, id: @content_choice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_choice
    assert_response :success
  end

  test "should update content_choice" do
    patch :update, id: @content_choice, content_choice: { content_question_id: @content_choice.content_question_id, right: @content_choice.right, text: @content_choice.text }
    assert_redirected_to content_choice_path(assigns(:content_choice))
  end

  test "should destroy content_choice" do
    assert_difference('ContentChoice.count', -1) do
      delete :destroy, id: @content_choice
    end

    assert_redirected_to content_choices_path
  end
end
