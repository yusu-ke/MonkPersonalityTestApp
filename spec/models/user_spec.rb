require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    it "name、email、passwordとpassword_confirmationが存在すれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameが存在しなければ登録できない" do
      without_name = build(:user, name: "")
      expect(without_name).to be_invalid
    end

    it "emailが存在しなければ登録できない" do
      without_email = build(:user, email: "")
      expect(without_email).to be_invalid
    end

    it "passwordが存在しなければ登録できない" do
      without_password = build(:user, password: "")
      expect(without_password).to be_invalid
    end

    it "password_confirmationが存在しなければ登録できない" do
      without_password_confirmation = build(:user, password_confirmation: "")
      expect(without_password_confirmation).to be_invalid
    end

    it "passwordとpassword_confirmationが異なれば登録できない" do
      different_password_password_confirmation = build(:user, password: "password", password_confirmation: "password1")
      expect(different_password_password_confirmation).to be_invalid
    end

    it "emailが一意である" do
      create(:user, email: "test@email.com")
      uniqueness_email = build(:user, email: "test@email.com")
      expect(uniqueness_email).to be_invalid
    end

    it "Passordが8文字未満であれば登録できない" do
      short_password = build(:user, password: "aaaa", password_confirmation: "aaaa")
      expect(short_password).to be_invalid
    end
  end
end
