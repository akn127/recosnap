require 'rails_helper'

RSpec.describe "記録を投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @record = FactoryBot.create(:record)
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'ニックネーム', with: @user.name
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('記録する')
      # 投稿ページに移動する
      visit new_record_path
      # フォームに情報を入力する
      fill_in 'record-title', with: @record.title
      select '旅行', from: 'record[category_id]'
      fill_in 'record_date', with: @record.date
      fill_in 'record-place', with: @record.place
      fill_in 'record-with', with: @record.with
      fill_in 'record-text', with: @record.text
      fill_in 'record-url', with: @record.url
      select 'open', from: 'record[status]'
      # 送信するとRecordモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿したタイトルの記録が存在することを確認する
      expect(page).to have_content(@record.title)
      # トップページには先ほど投稿したタイトルの記録が存在することを確認する
      expect(page).to have_content(@record.date)
      # トップページには先ほど投稿したタイトルの記録が存在することを確認する
      expect(page).to have_content(@record.place)
    end
  end

  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit new_user_session_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('記録する')
    end
  end

end
