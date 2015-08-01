require 'spec_helper'

describe SessionsController do
  describe '.create' do
    let(:user) { Fabricate(:user) }

    context 'logout' do
      before do
        sign_in(user)
      end

      it 'should return sueccess' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        delete :destroy
        expect(response).to be_success
      end
    end
  end
end
