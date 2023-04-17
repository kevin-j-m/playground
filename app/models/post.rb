class Post < ApplicationRecord
  def self.publish_all
    Post.all.map(&:publish)
  end

  def publish; end
end
