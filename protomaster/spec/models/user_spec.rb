require 'rails_helper'

RSpec.describe UserController, type: :controller do
  before do
    @user = User.create(number: 00000, name: 'hoge', password: 'hoge')
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

    describe ':numberが重複する場合' do
      it 'usert登録に失敗' do
        @user.save
        user2 = User.create(number: '00000', name: 'hoge', password: 'hoge')
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

    describe ':passwordの「空でないことの確認」' do
      context ':passwordが空でない場合' do
        it 'user登録に成功' do
          expect(@user.save).to eq true
        end
      end
      context ':passwordが空の場合' do
        it 'user登録に失敗' do
          @user.password_digest = ''
          expect(@user.save).to eq false
        end
      end
    end

    describe ':admin_userの値によるuser登録の結果' do
      context ':admin_userが1のユーザーによるuser登録' do
        it 'user登録に成功' do
          current_user = User.create(:number=>11111, :name=>"hoge", :password_digest=>"hoge", :admin_user=>1)
          controller.instance_variable_set(:@current_user, current_user)
          post :signin, params: {number: 22222, name: 'hoge', password_digest: 'hoge'}
          expect(flash[:notice]).to eq "ユーザー登録を完了しました。社員番号:22222,名前:hoge"
        end
      end
      context ':admin_userが0のユーザーによるuser登録' do
        it 'user登録に失敗' do
          current_user = User.create(number: 11111, name: 'hoge', password_digest: 'hoge')
          controller.instance_variable_set(:@current_user, current_user)
          post :signin, params: {number: 22222, name: 'hoge', password_digest: 'hoge'}
          expect(flash[:notice]).to eq "管理者権限を持っていません。"
        end
      end
    end
  end

  describe '#login' do
    before do
      @user.save
    end
    context ':userと:password_digestが一致' do
      it 'ログイン成功' do
        post :login, params: {number: 00000, password_digest: 'hoge'}
        expect(session[:user_id]).to eq @user.id
      end
    end
    context ':userと:password_digestが不一致' do
      it 'ログイン失敗' do
        post :login, params: {number: 00000, password_digest: 'hogehoge'}
        expect(flash[:notice]).to eq "社員番号とパスワードが一致しませんでした。"
      end
    end
  end

end
