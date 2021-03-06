require 'test_helper'

class AssessmentsControllerTest < ActionController::TestCase
  setup do
    sign_in :user, User.where(:email => 'admin@example.com').first
    @assessment = assessments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assessments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assessment" do
    #todo
    #assert_difference('Assessment.count') do
    #  post :create, params: {assessment: { remark: @assessment.remark, student_id: @assessment.student_id, user_id: @assessment.user_id, value: @assessment.value, week: @assessment.week }}
    #end
    #
    #assert_redirected_to assessment_path(assigns(:assessment))
  end

  test "should show assessment" do
    get :show, params: {id: @assessment}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @assessment}
    assert_response :success
  end

  test "should update assessment" do
    #todo
    #patch :update, params: {id: @assessment, assessment: { remark: @assessment.remark, student_id: @assessment.student_id, user_id: @assessment.user_id, value: @assessment.value, week: @assessment.week }}
    #assert_redirected_to assessment_path(assigns(:assessment))
  end

  test "should destroy assessment" do
    assert_difference('Assessment.count', -1) do
      delete :destroy, params: {id: @assessment}
    end

    assert_redirected_to assessments_path
  end
end
