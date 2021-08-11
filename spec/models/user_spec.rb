require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {User.create!(name:'John',password: '123456',email: 'john@mail')}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:session_token)}
  it {should validate_presence_of(:activation_token)}

  it {should validate_uniqueness_of(:email)}
  it {should validate_uniqueness_of(:activation_token)}
  it {should validate_uniqueness_of(:session_token)}

  it {should validate_length_of(:password).is_at_least(6).allow_nil}

  describe "#is_password?" do
    it "should return true if the password matches" do
      expect(user.is_password?('123456')).to be true
    end

    it "should return false if there is a password missmatch" do
      expect(user.is_password?('12345')).to be false
    end
  end

  describe "#reset_session_token" do
    it "should change the value of the session_token" do
      token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(token)
    end

    it "should save the model" do
      expect(user).to receive(:save!)
      user.reset_session_token!
    end

    it "should return the new session_token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe "::find_by_credentials" do
    before(:each) { user.reload}
    it "should return nil if the user doesn't exist in the database" do
      expect(User.find_by_credentials('john@mai','123456')).to be_nil
    end
    it "should return nil if the password doesn't match" do
      expect(User.find_by_credentials('john@mail','12345')).to be_nil
    end
    it "should return the user if the credentials match" do
      user2 = User.find_by_credentials('john@mail','123456')
      expect(user2).to be_an(User)
      expect(user2.email).to eq('john@mail')
      expect(user2.name).to eq('John')
      expect(user2.is_password?('123456')).to be true
    end
  end 
end
