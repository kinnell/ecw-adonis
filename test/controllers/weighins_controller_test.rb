require 'test_helper'

class WeighinsControllerTest < ActionController::TestCase
  setup do
    @weighin = weighins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weighins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weighin" do
    assert_difference('Weighin.count') do
      post :create, weighin: { weight: @weighin.weight }
    end

    assert_redirected_to weighin_path(assigns(:weighin))
  end

  test "should show weighin" do
    get :show, id: @weighin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weighin
    assert_response :success
  end

  test "should update weighin" do
    patch :update, id: @weighin, weighin: { weight: @weighin.weight }
    assert_redirected_to weighin_path(assigns(:weighin))
  end

  test "should destroy weighin" do
    assert_difference('Weighin.count', -1) do
      delete :destroy, id: @weighin
    end

    assert_redirected_to weighins_path
  end
end
