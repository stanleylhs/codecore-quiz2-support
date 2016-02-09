require 'rails_helper'

RSpec.describe Request, type: :model do
  describe "validations" do
    it "doesn't allow creating a request with no name" do 
      # GIVEN: c w/o title
      r = Request.new
      # WHEN: validation
      r.valid?
      # THEN: expect false
      expect(r.errors).to have_key(:name)      
      # should is deprecated
    end
    it "requires an email" do
      # Give
      r = Request.new
      # When
      r.valid?
      # Then
      # have_key is a matcher
      # has_key
      expect(r.errors).to have_key(:email)
    end
    # it "requires a goal that must be greater than 10" do
    #   c = Campaign.new(goal: 1)
    #   c.valid?
    #   # don't check c.goal! It should be blackbox testing!
    #   # Test as if we don't know the implementation.
    #   # as the presence was checked before hand, we can be sure this will be a numericality error
    #   expect(c.errors).to have_key(:goal)
    #   # specific test is too much
    #   # expect(c.errors[:goal]).to include("must be greater than 10")
    # end
    # it "requires a name that must be unique" do
    #   # Use Factory

    #   # need to give it goal and description to prevent db rollback
    #   Campaign.create(name: "Game", goal: 100, description: "abc")
    #   c = Campaign.new(name: "Game")
    #   c.valid?
    #   expect(c.errors).to have_key(:name)
    # end
  end
end
