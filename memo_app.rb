# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

# JSONファイル読み込み
def read_memo
  File.open('memos.json') { |file| JSON.parse(file.read) }
end

# JSONファイル上書き
def dump_memo(hash)
  File.open('memos.json', 'w') { |file| JSON.dump(hash, file) }
end

# トップページ。メモのタイトル一覧
get '/memo-app' do
  @index_html = ''
  hash = read_memo
  hash.each do |key, value|
    @index_html += "<li><a href=\"/memo-app/#{key}\">#{value['title']}</a></li>"
  end
  erb :index
end

# 新規作成ページ
get '/memo-app/new' do
  erb :new
end

# 新規作成ページで「追加」を押す操作。トップページにリダイレクト。
post '/memo-app' do
  id = 1
  hash = read_memo
  id_count = []
  hash.each_key { |key| id_count << key.to_i }
  id += 1 while id_count.include?(id)
  hash[id] = { 'title' => params[:title], 'content' => params[:content] }
  dump_memo(hash)
  redirect '/memo-app'
end

# トップページで各メモタイトルを押した先の詳細ページ
get '/memo-app/:id' do
  hash = read_memo
  @id = params[:id]
  @title = hash[params[:id]]['title']
  @content = escape_xss(hash[params[:id]]['content'])
  erb :detail
end

# メモ詳細を出力する時のXSS対策と改行のメソッド。
def escape_xss(text)
  text.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('\'', '&#39;').gsub('\"', '&quot;').gsub("\r\n", '<br>')
end

# 詳細ページの「変更」を押した先の編集ページ。
get '/memo-app/:id/edit' do
  hash = read_memo
  @id = params[:id]
  @title = hash[params[:id]]['title']
  @content = hash[params[:id]]['content']
  erb :edit
end

# 編集ページで「変更」を押す操作。トップページにリダイレクト。
patch '/memo-app/:id' do
  hash = read_memo
  hash[params[:id]] = { 'title' => params[:title], 'content' => params[:content] }
  dump_memo(hash)
  redirect '/memo-app'
end

# 詳細ページの「削除」を押す操作。トップページにリダイレクト。
delete '/memo-app/:id' do
  hash = read_memo
  hash.delete(params[:id])
  dump_memo(hash)
  redirect '/memo-app'
end
