get '/' do
  @errors
  # let user create new short URL, display a list of shortened URLs
  erb :index
end

post '/urls' do
  # create a new Url
  @url = Url.new(long_url: params[:long], click_count: 0)
  if @url.save
    p @url
    erb :success_page
  else
    p @error

    @error = @url.errors.messages[:long_url][0]
    p @error
    erb :index
  end
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  @url = Url.find_by_short_url(params[:short_url])
  @url.click_count += 1
  @url.save
  redirect (@url.long_url)
end

