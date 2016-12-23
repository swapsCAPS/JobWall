require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  describe "text parsing" do

    it "finds the subject" do
      jb = JobPosting.new
      expect(jb.company_name( "Assistant Store Managers at Dollar Tree are responsible for the following:" )).to eq("Dollar Tree")
    end
  end
end
