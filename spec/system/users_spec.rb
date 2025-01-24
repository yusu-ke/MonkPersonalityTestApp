require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  describe "ログイン前" do
    describe "ユーザー新規登録" do
      context "フォームの入力値が正常" do
        it "新規登録が成功する" do
          visit new_user_registration_path

          fill_in "user_name", with: "name"
          fill_in "user_email", with: "email@email.com"
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_button "登録する"
          expect(page).to have_content "アカウント登録が完了しました。"
        end
      end

      context "ユーザー名が未入力" do
        it "新規登録が失敗する" do
          visit new_user_registration_path

          fill_in "user_name", with: ""
          fill_in "user_email", with: "email@email.com"
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_button "登録する"
          expect(page).to have_content "1 件エラーが発生しました。以下の内容をご確認ください。"
          expect(page).to have_content "ユーザー名を入力してください"
        end
      end

      context "登録済のメールアドレスを使用" do
        it "新規登録が失敗する" do
          existed_user = create(:user)
          visit new_user_registration_path

          fill_in "user_name", with: "username"
          fill_in "user_email", with: existed_user.email
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          click_button "登録する"
          expect(page).to have_content "1 件エラーが発生しました。以下の内容をご確認ください。"
          expect(page).to have_content "メールアドレスはすでに存在します"
        end
      end
    end

    describe "ポスト機能" do
      context "未ログイン" do
        it "ログイン一覧へのアクセスが失敗する" do
          visit posts_path

          expect(page).to have_content "ログインもしくはアカウント登録してください。"
        end
      end
    end

    describe "マイページ" do
      context "未ログイン" do
        it "マイページへのアクセスが失敗する" do
          visit profile_path(user)
          expect(page).to have_content "ログインもしくはアカウント登録してください。"
        end

        it "他のユーザのマイページへのアクセスが失敗する" do
          another_user = create(:user)
          visit profile_path(another_user)
        end
      end
    end
  end

  describe "ログイン後" do
    before { login_as(user) }

    describe "ユーザ編集" do
      context "フォームの入力値が正常" do
        it "ユーザ編集が成功する" do
          visit edit_profile_path

          fill_in "user_name", with: "update_name"
          fill_in "user_email", with: "update_email"
          click_button "保存する"
          expect(current_path).to eq edit_profile_path
        end
      end

      context "ユーザ名が未入力" do
        it "ユーザ編集が失敗する" do
          visit edit_profile_path

          fill_in "user_name", with: ""
          fill_in "user_email", with: "update_email"
          click_button "保存する"
          expect(current_path).to eq edit_profile_path
        end
      end

      context "登録済メールアドレスを使用" do
        it "ユーザ編集が失敗する" do
          visit edit_profile_path
          other_user = create(:user)
          fill_in "user_name", with: "user_name"
          fill_in "user_email", with: other_user.email
          click_button "保存する"
          expect(current_path).to eq edit_profile_path
        end
      end
    end
  end
end
