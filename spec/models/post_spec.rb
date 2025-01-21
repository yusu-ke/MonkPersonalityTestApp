require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    it "すべてのバリデーションが機能しているのか" do
      user = User.create(email: "user@email.com", password: "password")
      post = build(:post, user: user, post_images: [ fixture_file_upload('image_test.jpg') ])
      expect(post).to be_valid
      expect(post.errors).to be_empty
    end

    it "temple_nameがない場合にバリデーションが機能する" do
      without_temple_name = build(:post, temple_name: "")
      expect(without_temple_name).to be_invalid
      expect(without_temple_name.errors[:temple_name]).to eq ["を入力してください"]
    end

    it "commentがない場合にバリデーションが機能する" do
      without_comment = build(:post, comment: "")
      expect(without_comment).to be_invalid
      expect(without_comment.errors[:comment]).to eq ["を入力してください"]
    end


    it "post_imagesが3枚より多い場合、無効であること" do
      post = build(:post, post_images: [fixture_file_upload('image_test.jpg'),fixture_file_upload('image_test.jpg'),fixture_file_upload('image_test.jpg'),fixture_file_upload('image_test.jpg')])
      expect(post).to_not be_valid
    end
  end
end
      