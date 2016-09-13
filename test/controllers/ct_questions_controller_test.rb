require 'test_helper'

class CtQuestionsControllerTest < ActionController::TestCase
  setup do
    @ct_question = ct_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ct_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ct_question" do
    assert_difference('CtQuestion.count') do
      post :create, ct_question: { question: @ct_question.question, tree_id: @ct_question.tree_id }
    end

    assert_redirected_to ct_question_path(assigns(:ct_question))
  end

  test "should show ct_question" do
    get :show, id: @ct_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ct_question
    assert_response :success
  end

  test "should update ct_question" do
    patch :update, id: @ct_question, ct_question: { question: @ct_question.question, tree_id: @ct_question.tree_id }
    assert_redirected_to ct_question_path(assigns(:ct_question))
  end

  test "should destroy ct_question" do
    assert_difference('CtQuestion.count', -1) do
      delete :destroy, id: @ct_question
    end

    assert_redirected_to ct_questions_path
  end
end
