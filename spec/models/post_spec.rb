require 'rails_helper'

RSpec.describe Post, type: :model do
  describe ".publish_all" do
    # it "publishes all posts, but doesn't succeed because the mock is on a different object in memory" do
    #   to_publish = Post.create
    #   allow(to_publish).to receive(:publish)

    #   Post.publish_all

    #   expect(to_publish).to have_received(:publish)
    # end

    it "publishes all post, testing the return behavior but using any instance of" do
      # https://rspec.info/features/3-12/rspec-mocks/working-with-legacy-code/any-instance/
      Post.create
      allow_any_instance_of(Post).to receive(:publish).and_return("called publish")

      expect(Post.publish_all).to eq ["called publish"]
    end

    it "publishes all post by forcing the DB call to return the object in memory" do
      to_publish = Post.create
      allow(Post).to receive(:all).and_return([to_publish])
      allow(to_publish).to receive(:publish)

      Post.publish_all

      expect(to_publish).to have_received(:publish)
    end
  end
end
