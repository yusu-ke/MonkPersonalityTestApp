require 'rails_helper'


RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }

  describe "ログイン前" do
    context "フォーム入力が正常" do
      it "ログイン処理が成功する" do
        visit new_user_session_path

        fill_in "user_name", with: user.name
        fill_in "user_password", with: user.password
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
      end
    end

    context "フォームが未入力" do
      it "ログイン処理が失敗する" do
        visit new_user_session_path

        fill_in "user_name", with: ""
        fill_in "user_password", with: user.password
        click_button "ログイン"
        expect(page).to have_content "ユーザー名またはパスワードが違います。"
      end
    end
  end

  describe "ログイン後" do
    context "ログアウトボタンをクリック" do
      it "ログアウト処理が成功する" do
        login_as(user, scope: :user)
        visit root_path
        find("summary", text: "メニュー").click
        expect(page).to have_link("ログアウト")
        click_link "ログアウト"
        expect(page).to have_content "ログアウトしました。"
      end
    end
  end
end
