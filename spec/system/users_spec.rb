require 'rails_helper'

RSpec.describe "ユーザー登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー登録できるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # ログインページに移動する
      visit new_user_session_path
      # ログインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.name
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.nav').find('span').hover
      ).to have_content('ログアウト')
    end
  end

  context 'ユーザー登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      visit new_user_session_path
      # ログインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: ''
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq('/users')
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # ログインページに移動する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.name
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.nav').find('span').hover
      ).to have_content('ログアウト')
    end
  end

  context 'ログインできないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # ログインページに移動する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: ''
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end
