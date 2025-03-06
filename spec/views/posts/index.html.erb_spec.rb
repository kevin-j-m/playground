require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyText"
      ),
      Post.create!(
        title: "Other Title",
        body: "YourText"
      )
    ])
  end

  it "renders a list of posts" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Other Title/)
    expect(rendered).to match(/YourText/)
  end
end
