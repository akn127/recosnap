require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録' do
    context 'ユーザー登録できる時' do
      it '必須項目全てに入力すると登録ができる' do
        expect(@user).to be_valid
      end
      it 'パスワードは6文字以上での入力があれば登録できる' do
        @user.password = 'abc123'
        expect(@user).to be_valid
      end
      it 'パスワードは、半角英数字が混合されていれば登録できる' do
        @user.password = 'abc123'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できない時' do
      it 'ニックネームが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nameを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailは一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'passwordは6文字以上でないと登録できない' do
        @user.password = 'abc99'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordは半角英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'ａｂｃ９９９'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end
    end
  end

  end
