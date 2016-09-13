require 'test_helper'

class ContentQuestionsControllerTest < ActionController::TestCase
  setup do
    @content_question = content_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_question" do
    assert_difference('ContentQuestion.count') do
      post :create, content_question: { question: @content_question.question, tree_id: @content_question.tree_id }
    end

    assert_redirected_to content_question_path(assigns(:content_question))
  end

  test "should show content_question" do
    get :show, id: @content_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_question
    assert_response :success
  end

  test "should update content_question" do
    patch :update, id: @content_question, content_question: { question: @content_question.question, tree_id: @content_question.tree_id }
    assert_redirected_to content_question_path(assigns(:content_question))
  end

  test "should destroy content_question" do
    assert_difference('ContentQuestion.count', -1) do
      delete :destroy, id: @content_question
    end

    assert_redirected_to content_questions_path
  end
end
