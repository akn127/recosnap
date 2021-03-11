require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @record = FactoryBot.build(:record)
  end

  describe '記録の登録' do
    context '記録の登録ができる時' do
      it 'フォームに全てデータがあれば登録できる' do
        expect(@record).to be_valid
      end
      it '画像は空でも登録できる' do
        @record.image = ''
        expect(@record).to be_valid
      end
      it 'urlは空でも登録できる' do
        @record.url = ''
        expect(@record).to be_valid
      end
    end

    context '記録の登録ができない時' do
      it 'タイトルがなければ登録できない ' do
        @record.title = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Titleを入力してください')
      end
      it 'カテゴリはid1を選択した場合は登録できない' do
        @record.category_id = 1
        @record.valid?
        expect(@record.errors.full_messages).to include('Categoryは1以外の値にしてください')
      end
      it '日付の入力がなければ登録できない' do
        @record.date = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Dateを入力してください')
      end
      it '年月日全て選択しなければ登録できない' do
        @record.date = '2020-01'
        @record.valid?
        expect(@record.errors.full_messages).to include('Dateを入力してください')
      end
      it '場所の入力がなければ登録できない' do
        @record.place = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Placeを入力してください')
      end
      it 'おでかけの記録がなければ登録できない' do
        @record.text = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Textを入力してください')
      end
      it '公開・非公開は選択がなければ登録できない' do
        @record.status = ''
        @record.valid?
        expect(@record.errors.full_messages).to include('Statusを入力してください')
      end
    end
  end
end
