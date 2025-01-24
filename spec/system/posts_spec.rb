require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, post_images: [ fixture_file_upload('image_test.jpg') ]) }


  describe "ログイン前" do
    context "ポスト新規投稿にアクセスする" do
      it "ポスト新規投稿へのアクセスが失敗する" do
        visit new_post_path
        expect(page).to have_content("ログインもしくはアカウント登録してください。")
        expect(current_path).to eq new_user_session_path
      end
    end

    context "ポスト詳細にアクセスする" do
      it "ポスト詳細へのアクセスが失敗する" do
        visit post_path(post)
        expect(page).to have_content("ログインもしくはアカウント登録してください。")
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ログイン後" do
    before do
      login_as(user, scope: :user)
    end

    context "フォームの入力値が正常" do
      it "ポスト新規作成が成功する" do
        visit new_post_path
        fill_in "post_temple_name", with: "test_name"
        find('label[for="icon_0"]').click
        fill_in "post[map_attributes][address]", with: "東京タワー"
        find('a', text: '地名で検索').click
        attach_file "post[post_images][]", Rails.root.join("spec/fixtures/files/image_test.jpg")
        fill_in "post_comment", with: "test_comment"
        click_button "登録する"
        expect(page).to have_content("掲示板を作成しました。")
      end
    end

    context "フォームの入力値が不足" do
      it "ポスト新規作成が失敗する" do
        visit new_post_path
        fill_in "post_temple_name", with: ""
        find('label[for="icon_0"]').click
        fill_in "post[map_attributes][address]", with: "東京タワー"
        find('a', text: '地名で検索').click
        attach_file "post[post_images][]", Rails.root.join("spec/fixtures/files/image_test.jpg")
        fill_in "post_comment", with: "test_comment"
        click_button "登録する"
        expect(page).to have_content("掲示板の作成に失敗しました。")
        expect(page).to have_content("寺院・史跡名を入力してください")
      end
    end
  end

  describe "ポスト編集" do
    let!(:post) { create(:post, user: user, post_images: [ fixture_file_upload('image_test.jpg') ]) }
    let(:other_post) { create(:post, user: user, post_images: [ fixture_file_upload('image_test.jpg') ]) }

    before do
      login_as(user, scope: :user)
      visit edit_post_path(post)
    end

    context "フォームの入力値が正常" do
      it "ポスト編集が成功する" do
        fill_in "post_temple_name", with: "test_name"
        fill_in "post[map_attributes][address]", with: "京都タワー"
        find('a', text: '地名で検索').click
        attach_file "post[post_images][]", Rails.root.join("spec/fixtures/files/image_test.jpg")
        fill_in "post_comment", with: "updated_comment"
        click_button "更新する"
        expect(page).to have_content("掲示板を更新しました。")
      end
    end

    context "フォームの入力値が不足" do
      it "ポスト編集が失敗する" do
        fill_in "post_temple_name", with: ""
        fill_in "post[map_attributes][address]", with: "京都タワー"
        find('a', text: '地名で検索').click
        attach_file "post[post_images][]", Rails.root.join("spec/fixtures/files/image_test.jpg")
        fill_in "post_comment", with: "updated_comment"
        click_button "更新する"
        expect(page).to have_content("更新に失敗しました。")
        expect(page).to have_content("寺院・史跡名を入力してください")
      end
    end

    context "他ユーザのポスト編集にアクセスする" do
      let!(:other_user) { create(:user, email: "other@email.com") }
      let!(:other_post) { create(:post, user: other_user, post_images: [ fixture_file_upload('image_test.jpg') ]) }

      it "編集ページにアクセスが失敗する" do
        visit edit_post_path(other_post)
        expect(page).to have_content "権限がない、もしくは投稿が存在しません。"
        expect(current_path).to eq posts_path
      end
    end
  end

  describe "ポスト削除" do
    let!(:post) { create(:post, user: user, post_images: [ fixture_file_upload('image_test.jpg') ]) }
    before do
      login_as(user, scope: :user)
      visit post_path(post)
    end

    it "ポストの削除が成功する" do
      find("a#button-delete-#{post.id}").click
      expect(page.accept_confirm).to eq "削除してもいいですか？"
      expect(page).to have_content "削除しました。"
      expect(current_path).to eq posts_path
    end
  end
end
