require 'rails_helper'

RSpec.describe Map, type: :model do
  describe "バリデーション" do
    let(:post) { create(:post, post_images: [ fixture_file_upload('image_test.jpg') ]) }

    it "すべてのバリデーションが機能しているのか" do
      map = Map.build(address: "example_place", latitude: 35.6895, longitude: 139.6917, post: post)
      expect(map).to be_valid
      expect(map.errors).to be_empty
    end

    it "addressが空の場合は無効" do
      without_address = Map.build(address: "", latitude: 35.6895, longitude: 139.6917, post: post)
      expect(without_address).to be_invalid
      expect(without_address.errors[ :address ]).to eq ["を入力してください"]
    end
  end
end
