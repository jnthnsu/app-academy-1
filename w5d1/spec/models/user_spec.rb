require 'rails_helper'
require 'shoulda-matchers'

RSpec.describe User, type: :model do
  describe "username" do

    subject{create(:user)}

    it {should validate_presence_of :username}
    it {should validate_uniqueness_of :username}
    it {should validate_length_of(:password).is_at_least(6).on(:create)}
    it {should validate_presence_of :password_digest}
    it {should validate_uniqueness_of :password_digest}
    it {should validate_presence_of :session_token}
    it {should validate_uniqueness_of :session_token}
  end

  describe "password encryption" do
    before(:each) do
      @user = create(:user)
    end

    it 'does not save password' do
      user_db = User.find_by_username(@user.username)
      expect(user_db.password).to be_nil
    end

    it 'encrypts' do
      expect(BCrypt::Password).to receive(:create)
      build(:user)
    end

    it 'checks password' do
      user_db = User.find_by(username: @user.username)
      expect(user_db.is_password?(@user.password)).to be_truthy
    end
  end

  describe 'session_token' do
    before(:each) do
      @user = create(:user)
    end

    it 'assigns one' do
      expect(@user.session_token).not_to be_nil
    end
  end
end
