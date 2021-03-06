get '/' do
  @posts = Post.order('created_at DESC')
  erb :index
end

get '/user/signup' do
  erb :signup
end

post '/user/signup' do
  @user = User.new(params[:user])
    if @user.save 
      session[:user_id] = @user.id
      redirect '/'
    else
      redirect 'user/signup'
    end
end

post '/user/signin' do
  @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/user/profile"
    else
      redirect "/"
    end
end

get '/user/signout' do

  session.clear
  redirect '/'
end

get '/user/profile' do
  @user = User.find(session[:user_id])
  puts @user
  puts "*********************************************"
  @posts = current_user.posts
  puts @posts.empty?
  puts @posts.nil?
  @comments = current_user.comments
  puts @comments.empty?
  puts @comments.nil?
  erb :profile
end

get '/posts/create' do
  erb :new_post
end

post '/posts/create' do
  @post = Post.create(title: params[:post][:title], body: params[:post][:body], url: params[:post][:url], user_id: current_user.id)
  redirect '/'
end

get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  @comments = @post.comments
  erb :post
end

post '/post/:post_id/comment/create' do
  p params
  @post = Post.find(params[:post_id])
  @post.comments << Comment.create(body: params[:comment][:body], user_id: current_user.id)
  redirect '/'
end

post '/votes/posts/:post_id' do
  @post = Post.find(params[:post_id])
  @post.votes << Vote.create(up: params[:vote_choice])
  redirect "/posts/#{@post.id}"
end



get '/posts/:post_id/delete' do
  @post = Post.find(params[:post_id])
  @post.destroy

  redirect 'user/profile'
end

get '/comments/:comment_id/delete' do
  @comment = Comment.find(params[:comment_id])
  @comment.destroy

  redirect 'user/profile'
end

post '/votes/comments/:comment_id' do
  @comment = Comment.find(params[:comment_id])
  @comment.votes << Vote.create(up: params[:vote_choice])
  redirect "/posts/#{@comment.post.id}"
end

















