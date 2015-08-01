# == Schema Information
#
# Table name: users
#
#  id                      :uuid             not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  auth_token              :string           default(""), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string
#  last_name               :string
#  username                :string
#  username_lower          :string
#  photo_file_name         :string
#  photo_content_type      :string
#  photo_file_size         :integer
#  photo_updated_at        :datetime
#  background_file_name    :string
#  background_content_type :string
#  background_file_size    :integer
#  background_updated_at   :datetime
#  photo_fingerprint       :string
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'spec_helper'

describe User do

  describe '.associtation' do
  end

  describe '.validations' do
    let(:user) { Fabricate(:user) }

    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }

    describe 'email' do
      it 'accepets mail@example.com' do
        expect(user).to be_valid
      end

      it 'accepts mail+blubb@example.com' do
        user = Fabricate.build(:user, email: 'mail+blubb@example.com')
        expect(user).to be_valid
      end

      it 'rejects mail@mail@example.com' do
        user = Fabricate.build(:user, email: 'mail@mail@example.com')
        expect(user).to be_invalid
      end

      it 'rejects mailto:mail@example.com' do
        skip 'this SHOULD be invlaid'
        user = Fabricate.build(:user, email: 'mailto:mail@example.com')
        expect(user).to be_invalid
      end

      it 'should lowercase email' do
        user = Fabricate.build(:user, email: 'MAIL@ExaMple.Com')
        user.save
        expect(user.email).to eq('mail@example.com')
      end

      it 'should strip email' do
        user = Fabricate.build(:user, email: ' myemail@example.com ')
        user.save
        expect(user.email).to eq('myemail@example.com')
      end
    end

    describe 'name' do
      it 'should have a first_name' do
        user = Fabricate.build(:user)
        expect(user.first_name).to be_present
      end

      it 'should have a last_name present' do
        user = Fabricate.build(:user)
        expect(user.last_name).to be_present
      end
    end

    describe 'username' do
      it 'should be 3 chars or longer' do
        user = Fabricate.build(:user)
        user.username = 'aa'
        expect(user.save).to be false
      end

      it 'should never end with a dot' do
        skip 'FIX: Validation errors'
        user = Fabricate.build(:user)
        user.username = 'Bjorn.'
        expect(user.save).to be false
      end

      ['Bad Name', 'Other%Bad', 'With!', '@handle', 'sh', 'dontwork$'].each do |bad_username|
        it "should not allow '#{bad_username}'" do
          user = Fabricate.build(:user)
          user.username = bad_username
          expect(user.save).to be false
        end
      end

      it 'should lowercase username' do
        user = Fabricate.build(:user, username: 'MyUSerNAMe')
        user.save
        expect(user.username_lower).to eq('myusername')
      end
    end

    describe 'create' do
      subject { Fabricate.build(:user) }

      it { should be_valid }

      context 'after_save' do
        before { subject.save }

        it 'has auth token' do
          expect(subject.auth_token).to be_present
        end


      end
    end
  end
end
