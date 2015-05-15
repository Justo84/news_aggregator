require 'sinatra'
require 'pry'
require 'csv'

def articles_list(filename)
  articles = []

  CSV.foreach(filename, headers: true) do |row|
    articles << {
      title: row['title'],
      url: row['url'],
      description: row['description']
    }
  end

  articles
end

def add_article(filename, title, url, description)
  CSV.open(filename, 'a') do |csv|
    csv << [title, url, description]
  end
end

def valid_article(title, url, description)
  # if title = "" || url = "" || description = ""
  #   @error_message = "You must enter valid inputs"
  # # if params[:article][:title].empty? || params[:article][:url].empty? ||
  # #   params[:article][:description].empty?
  # #   @error_message = []
  # #   @error_message << "You must enter an article title." if params[:article][:title].empty?
  # #   @error_message << "You must enter a url" if params[:article][:url].empty?
  # #   @error_message << "You must enter a description" if params[:article][:description].empty?
  # erb :'articles/new'
  # else
    add_article('articles.csv', title, url, description)
    redirect '/articles'
  # end
end

get '/articles' do
  @articles = articles_list('articles.csv')
  erb :articles
end

get '/articles/new' do
  erb :'articles/new'
end

post '/articles' do
 @title = params[:article][:title]
 @url = params[:article][:url]
 @description = params[:article][:description]
 valid_article(@title, @url, @description)
 erb :articles
end

# get 'articles/:article' do
#   @title = params[:article][:title]
#   @url = params[:article][:url]
#   @description = params[:article][:description]
#   erb :article_info
# end
