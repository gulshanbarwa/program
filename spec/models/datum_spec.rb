require 'rails_helper'

RSpec.describe Datum, type: :model do
  it "is invalid without a plan" do
    datum = Datum.new
    expect(datum).to be_valid
  end
end

