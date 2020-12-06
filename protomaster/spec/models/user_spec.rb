require 'rails_helper'

RSpec.describe User, type: :request do
  before do
    @user = User.create(number: '00000', name: 'hoge', password_digest: 'hoge')
  end

  describe '#signin' do
    describe ':numberの「空でないこと」の確認' do
      context ':numbeが空でない場合' do
        it 'user登録に成功' do
          expect(@user.save).to eq true
        end
      end
      context ':numberが空の時' do
        it 'user登録に失敗' do
          @user.number = ''
          expect(@user.save).to eq false
        end
      end
    end

    describe '社員番号が重複する場合' do
      it 'usert登録に失敗' do
        @user.save
        user2 = User.create(number: '00000', name: 'hoge', password_digest: 'hoge')
        expect(user2.save).to eq false
      end
    end

    describe ':nameの「空でないことの確認」' do
      context ':nameが空でない場合' do
        it 'user登録に成功' do
          expect(@user.save).to eq true
        end
      end
      context ':nameが空の場合' do
        it 'user登録に失敗' do
          @user.name = ''
          expect(@user.save).to eq false
        end
      end
    end

    describe ':admin_userの値によるuser登録の結果' do
      context ':admin_userが1のユーザーによるuser登録' do
        it 'user登録に成功' do
          @current_user = User.create(number: '11111', name: 'hoge', password_digest: 'hoge')
          @current_user.admin_user = 1
          @current_user.save
          post '/user/signin', params: {number: '22222', name: 'hoge', password_digest: 'hoge'}
          expect(flash[:notice]).to eq "ユーザー登録を完了しました。社員番号:22222,名前:hoge"
        end
      end
      context ':admin_userが0のユーザーによるuser登録' do
        it 'user登録に失敗' do
          @current_user = User.create(number: '11111', name: 'hoge', password_digest: 'hoge')
          @current_user.save
          post '/user/signin', params: {number: '22222', name: 'hoge', password_digest: 'hoge'}
          expect(flash[:notice]).to eq "管理者権限を持っていません。"
        end
      end
    end



  end


end
