class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def show
    setter
  end

  def new
    @song = Song.new
  end

  def create
    # binding.pry
    @song = Song.new(song_params(:title, :released, :release_year, :artist_name, :genre))
    if @song.valid?
      @song.save

      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def edit
    setter
  end

  def update
    setter
    @song.assign_attributes(song_params(:title, :released, :release_year, :artist_name, :genre))
    if @song.valid?
      @song.update(song_params(:title, :released, :release_year, :artist_name, :genre))
      redirect_to song_path(@song)
    else
      render :edit
    end

    def destroy
      setter
      @song.destroy

      redirect_to songs_path
    end
  end

  private

  def song_params(*args)
    params.require(:song).permit(*args)
  end

  def setter
    @song = Song.find(params[:id])
  end
end
