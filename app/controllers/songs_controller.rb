class SongsController < ApplicationController
  # def index
  #   @songs = Song.all
  # end

  # def show
  #   @song = Song.find(params[:id])
  # end

  def index
    if params[:artist_id] 
      if Artist.find_by(id: params[:artist_id])
        @songs = Artist.find(params[:artist_id]).songs
      else 
        flash[:message] = "Artist not found."
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end
 
  def show
    if Song.find_by(id: params[:id])
      @song = Song.find_by(id: params[:id])
    else
      flash[:alert] = "Song not found."
      # redirect_to artists_path(params[:artist_id])
      redirect_to artist_songs_path(params[:artist_id])
    end
    
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

