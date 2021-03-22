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

RSpec.describe "記録の編集", type: :system do
  before do
    @record1 = FactoryBot.create(:record)
    @record2 = FactoryBot.create(:record)
  end

  context '記録の編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した記録の編集ができる' do
      # record1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'ニックネーム', with: @record1.user.name
      fill_in 'Eメール', with: @record1.user.email
      fill_in 'パスワード', with: @record1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 詳細ページに遷移する
      visit edit_record_path(@record1)
      # record1に「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#record-title').value
      ).to eq(@record1.title)
      # 投稿内容を編集する
      fill_in 'record-title', with: "#{@record1.title} + 編集したタイトル"
      # 編集してもRecordモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(0)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿したタイトルの記録が存在することを確認する
      expect(page).to have_content("#{@record1.title} + 編集したタイトル")
    end
  end
  context '記録の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記録の編集画面には遷移できない' do
      # record1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'ニックネーム', with: @record1.user.name
      fill_in 'Eメール', with: @record1.user.email
      fill_in 'パスワード', with: @record1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # みんなの記録ページに遷移する
      visit lists_path
      # record2の詳細ページに遷移する
      visit list_path(@record2)
      # 「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # ログインページにいる
      visit new_user_session_path
      # 「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe '投稿削除', type: :system do
  before do
    @record1 = FactoryBot.create(:record)
    @record2 = FactoryBot.create(:record)
  end
  context '投稿の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # record1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'ニックネーム', with: @record1.user.name
      fill_in 'Eメール', with: @record1.user.email
      fill_in 'パスワード', with: @record1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 詳細ページに遷移する
      visit record_path(@record1)
      # record1に「編集」ボタンがあることを確認する
      expect(page).to have_content('削 除')
      # 投稿を削除できる
      click_link "削 除"
      expect{
        expect(page.accept_confirm).to eq "記録を削除してもよろしいですか？"
        sleep 0.5
      }.to change { Record.count }.by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページにはrecord1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@record1.text}")
    end
  end
  context '投稿の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # record1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'ニックネーム', with: @record1.user.name
      fill_in 'Eメール', with: @record1.user.email
      fill_in 'パスワード', with: @record1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # みんなの記録ページに遷移する
      visit lists_path
      # record2の詳細ページに遷移する
      visit list_path(@record2)
      # 「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削 除')
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # ログインページにいる
      visit new_user_session_path
      # 「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削 除')
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # ログインページにいる
      visit new_user_session_path
      # 「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削 除')
    end
  end
end
