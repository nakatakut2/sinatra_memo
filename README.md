# アプリ概要
Ruby 及び PostgreSQL を利用した簡易的なメモアプリケーションです。
ご自身の端末に Ruby 及び PostgreSQL をご用意ください。
プログラム内では"id"、"title"、"content"の３つのカラムを想定しています。

# 起動手順
1. 任意のディレクトリを作成し、このリポジトリをクローンしてください。
```
$ git clone git@github.com:nakatakut2/sinatra_memo.git
```
2. Gemをインストールしてください。
```
$ bundle install
```
3. `memo_app.rb`を実行してください。
```
$ bundle exec ruby memo_app.rb
```
4. ブラウザで http://localhost:4567/memo-app にアクセスしてください。

# 使用方法
## メモの追加
【追加】をクリックして、タイトルおよび内容を入力し【保存】をクリックしてください。
タイトルが一覧で表示されます。
題字の【メモアプリ】をクリックすると、いつでも一覧に戻れます。
## メモの確認
タイトル名をクリックしてください。
## メモの編集
タイトル名をクリックして【変更】をクリックしてください。
タイトルと内容を編集して【変更】をクリックしてください。
※ 確認画面は出ないので、注意してください。
## メモの削除
タイトル名をクリックして【削除】をクリックしてください。
※ 確認画面は出ないので、注意してください。
