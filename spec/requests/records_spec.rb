require 'rails_helper'

RSpec.describe "Records", type: :request do

  let(:user) { FactoryBot.create(:user) }

  before do
    @record = FactoryBot.create(:record)
  end

  describe "GET /records" do
    context '未ログインユーザーの場合' do
      it 'indexアクションのレスポンスのステータスが「302（失敗）」であることを確認' do
        get root_path
        expect(response).to have_http_status(302)
      end
      it 'indexアクションを行うとログインページに遷移する' do
        get root_path
        expect(response).to redirect_to "/users/sign_in"
      end
    end

    context 'ログイン済みユーザーの場合' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      end
      it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
      end
    end
  end
end
