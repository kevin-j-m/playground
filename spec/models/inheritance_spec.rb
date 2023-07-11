require "spec_helper"

class VinylAlbum
  def shape
    :circle
  end

  def audio_technology
    :analog
  end

  def max_minutes
    46
  end
end

class Ep < VinylAlbum
  def max_minutes
    30
  end
end

# https://rspec.info/features/3-12/rspec-core/example-groups/shared-examples/
RSpec.shared_examples "an album" do |max_minutes|
  let(:album) { described_class.new }

  describe "#shape" do
    it "is a circle" do
      expect(album.shape).to eq :circle
    end
  end

  describe "audio_technology" do
    it "is analog" do
      expect(album.audio_technology).to eq :analog
    end
  end

  describe "#max_minutes" do
    it "has a maximum number of minutes" do
      expect(album.max_minutes).to eq expected_max_minutes
    end

    it "is #{max_minutes} minutes" do
      expect(album.max_minutes).to eq max_minutes
    end
  end
end

RSpec.describe VinylAlbum do
  it_behaves_like "an album", 46 do
    let(:expected_max_minutes) { 46 }
  end

  describe "#shape" do
    it "is a circle" do
      album = VinylAlbum.new

      expect(album.shape).to eq :circle
    end
  end

  describe "audio_technology" do
    it "is analog" do
      album = VinylAlbum.new

      expect(album.audio_technology).to eq :analog
    end
  end

  describe "#max_minutes" do
    it "is 46 minutes" do
      album = VinylAlbum.new

      expect(album.max_minutes).to eq 46
    end
  end
end

RSpec.describe Ep do
  it_behaves_like "an album", 30 do
    let(:expected_max_minutes) { 30 }
  end

  describe "#shape" do
    it "is a circle" do
      album = Ep.new

      expect(album.shape).to eq :circle
    end
  end

  describe "audio_technology" do
    it "is analog" do
      album = Ep.new

      expect(album.audio_technology).to eq :analog
    end
  end

  describe "#max_minutes" do
    it "is 30 minutes" do
      album = Ep.new

      expect(album.max_minutes).to eq 30
    end
  end
end
