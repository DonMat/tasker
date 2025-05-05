require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should have_many(:sessions).dependent(:destroy) }
  it { should validate_presence_of(:name) }

  it 'normalize email_address' do
    email_address = 'TEST@example.com'
    user = create(:user, email_address:)
    expect(user.email_address).to eq(email_address.downcase)
  end
end
