require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { Fabricate(:user) }

  before do
    sign_in(user)
  end

  describe "GET #me" do
    it "returns http success" do
      get :me
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, username: user.username
      expect(response).to have_http_status(:success)
    end
  end

  describe '.password_reset' do
    context 'invalid token' do
      before do
        put :finish_password_reset, reset_password_token: 'random_token'
      end

      it 'should return not success' do
        expect(response).not_to be_success
      end
    end

    context 'empty token' do
      before do
        @user = Fabricate(:user)
        post :start_password_reset, login: @user.email
      end

      it 'should return success' do
        expect(last_email.to).to include(@user.email)
        token = extract_token_from_email(:reset_password)
        expect(last_email.to_s).to include(token)

        put :finish_password_reset, { reset_password_token: token, password: 'newpassword' }
        is_expected.to respond_with 200
      end

      it 'should return error with short password' do
        token = extract_token_from_email(:reset_password)

        put :finish_password_reset, { reset_password_token: token, password: 'short' }
        is_expected.to respond_with 422
      end
    end
  end

end
