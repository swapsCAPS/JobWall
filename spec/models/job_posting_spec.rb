require 'rails_helper'

RSpec.describe JobPosting, type: :model do
  describe "text parsing" do

    it "can strip unkwown suffix" do
      jb = JobPosting.new
      expect(jb.strip_unknown_suffix( "Codaisseur[!]" )).to eq("Codaisseur")
    end

    it "can find unkown words" do
      jb = JobPosting.new
      expect(jb.unkown_word?( "Codaisseur[!]" )).to eq(true)
    end

    it "finds the object" do
      jb = JobPosting.new
      expect(jb.company_name( "Codaisseur is looking for an experienced developer." )).to eq("Codaisseur")
    end
  end
end
