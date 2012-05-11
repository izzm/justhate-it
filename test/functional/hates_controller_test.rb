require 'test_helper'

class HatesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Hate.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Hate.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Hate.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to hate_url(assigns(:hate))
  end

  def test_edit
    get :edit, :id => Hate.first
    assert_template 'edit'
  end

  def test_update_invalid
    Hate.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Hate.first
    assert_template 'edit'
  end

  def test_update_valid
    Hate.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Hate.first
    assert_redirected_to hate_url(assigns(:hate))
  end

  def test_destroy
    hate = Hate.first
    delete :destroy, :id => hate
    assert_redirected_to hates_url
    assert !Hate.exists?(hate.id)
  end
end
