# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'cgi'
require 'pg'

# DBに接続
def connection
  PG.connect(dbname: 'memo_test')
end

# トップページ。メモのタイトル一覧
get '/memo-app' do
  @result = connection.exec('SELECT * FROM memo;')
  erb :index
end

# 新規作成ページ
get '/memo-app/new' do
  erb :new
end

# 新規作成ページで「追加」を押す操作。トップページにリダイレクト。
post '/memo-app' do
  connection.exec_params('INSERT INTO memo (title, content) VALUES ($1, $2)', [params[:title], params[:content]])
  redirect '/memo-app'
end

# トップページで各メモタイトルを押した先の詳細ページ
get '/memo-app/:id' do
  result = connection.exec_params('SELECT * FROM memo WHERE id = $1', [params[:id]])
  @id = params[:id]
  @title = CGI.escape_html(result[0]['title'])
  @content = CGI.escape_html(result[0]['content'])
  erb :detail
end

# 詳細ページの「変更」を押した先の編集ページ。
get '/memo-app/:id/edit' do
  result = connection.exec_params('SELECT * FROM memo WHERE id = $1', [params[:id]])
  @id = result[0]['id']
  @title = result[0]['title']
  @content = result[0]['content']
  erb :edit
end

# 編集ページで「変更」を押す操作。トップページにリダイレクト。
patch '/memo-app/:id' do
  connection.exec_params('UPDATE memo SET title = $1, content = $2 WHERE id = $3', [params[:title], params[:content], params[:id]])
  redirect '/memo-app'
end

# 詳細ページの「削除」を押す操作。トップページにリダイレクト。
delete '/memo-app/:id' do
  connection.exec_params('DELETE FROM memo WHERE id = $1', [params[:id]])
  redirect '/memo-app'
end
