#require 'rails_helper'

#RSpec.describe User, type: :model do
 # pending "add some examples to (or delete) #{__FILE__}"
#end

require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid without a name" do
    user = User.new
    expect(user).to_not be_valid
  end

  it "is invalid without a valid email" do
    user = User.new(email: "invalid_email")
    expect(user).to_not be_valid
  end

  it "is invalid without a contact" do
    user = User.new
    expect(user).to_not be_valid
  end

  it "is invalid without a password" do
    user = User.new
    expect(user).to_not be_valid
  end
end