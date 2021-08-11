require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {User.create(name:'John',password: '123456',email: 'john@mail')}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:session_token)}
  it {should validate_presence_of(:activation_token)}

  it {should validate_uniqueness_of(:email)}
  it {should validate_uniqueness_of(:activation_token)}
  it {should validate_uniqueness_of(:session_token)}

  it {should validate_length_of(:password).is_at_least(6).allow_nil}
end
