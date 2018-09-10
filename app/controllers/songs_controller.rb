require 'rack-flash'
class SongsController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  use Rack::Flash

  get '/songs' do
    erb :'/songs/index'
  end
  
  get '/songs/new' do
    erb :'/songs/new'
  end
  
  post '/songs' do
    @song = Song.create(name: params['Name'])
    artist = Artist.find_by_slug(params['Artist Name'])
    if artist.nil?
      artist = Artist.create(name: params['Artist Name'])
      artist.songs << @song
    else
      @song.artist = artist
    end
    
    if !params['Genre Name'].empty?
      genre = Genre.create(name: params['Genre Name'])
      @song.genres << genre
    end
<<<<<<< HEAD
    genre_ids = params['genres']
=======
    genre_ids = params['genre_ids']
>>>>>>> 7ac881a468f3a5239997cc5527511a7d8fbc1fa3
    if !genre_ids.nil?
      genre_ids.each do |g_id|
        genre = Genre.find_by(id: g_id)
        @song.genres << genre
      end
    end
    @song.save
    flash[:message] = "Successfully created song."

    redirect to ("songs/#{@song.slug}")
  end
  
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if !@song.nil?
      @artist = Artist.find(@song.artist_id)
    end

    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    if !@song.nil?
      @artist = Artist.find(@song.artist_id)
    end
    erb :'/songs/edit'
  end


<<<<<<< HEAD

=======
  patch '/songs/:slug' do
    binding.pry
    @song = Song.find_by_slug(params[:slug])
    @song.update(params['Song Name'])
    artist = Artist.find_by_slug(params['Artist Name'])
    if  !artist.nil?
      artist_obj = Artist.create(name: params['Artist Name'])
      @song.artists << artist_obj
    else
      @song.artist = artist
    end
    
    
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end
>>>>>>> 7ac881a468f3a5239997cc5527511a7d8fbc1fa3
end