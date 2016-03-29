require 'rails_helper'

RSpec.describe Label, type: :model do
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:colour) }
  it { should validate_uniqueness_of(:name).scoped_to([:colour])}
end
