
require 'rails_helper'

RSpec.describe PersonHelper, type: :helper do
  describe "#extract_gender" do
    it "extract 'm' to 'Male'" do
      expect(helper.extract_gender("m")).to eq("Male")
    end

    it "extract 'M' to 'Male'" do
      expect(helper.extract_gender("M")).to eq("Male")
    end

    it "extract 'male' to 'Male'" do
      expect(helper.extract_gender("male")).to eq("Male")
    end

    it "extract 'f' to 'Female'" do
      expect(helper.extract_gender("f")).to eq("Female")
    end

    it "extract 'F' to 'Female'" do
      expect(helper.extract_gender("F")).to eq("Female")
    end

    it "extract 'female' to 'Female'" do
      expect(helper.extract_gender("female")).to eq("Female")
    end

    it "extract other values to 'Unknown'" do
      expect(helper.extract_gender("unknown")).to eq("Unknown")
    end
  end

  describe "#title_case" do
    it "returns nil for nil input" do
      expect(helper.title_case(nil)).to be_nil
    end

    it "capitalizes the first letter of each word" do
      expect(helper.title_case("john doe")).to eq("John Doe")
    end

    it "handles single-word input" do
      expect(helper.title_case("apple")).to eq("Apple")
    end

    it "handles already title-cased input" do
      expect(helper.title_case("John Doe")).to eq("John Doe")
    end

    it "handles input with extra spaces" do
      expect(helper.title_case("   alice   in   wonderland   ")).to eq("Alice In Wonderland")
    end
  end
end
