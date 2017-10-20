class PhotosController < ApplicationController
  before_action :set_gallery, only: %i[index create new]
  before_action :set_photo, only: %i[show edit update destroy]

  # GET /galleries/1/photos
  # GET /galleries/1/photos.json
  def index
    @photos = @gallery.photos
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    index = @gallery.photos.index(@photo)
    @next = @gallery.photos[index + 1].id if index < @gallery.photos.length - 1
    @prev = @gallery.photos[index - 1].id if index > 0

    unless params[:exif]
      @photo.views += 1
      @photo.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js do
        if params[:exif]
          render 'exif'
        else
          render 'show'
        end
      end
    end
  end

  # GET /galleries/1/photos/new
  def new
    @photo = Photo.new
    @uploader = @photo.img
    @uploader.success_action_redirect = gallery_url(@gallery)
  end

  # GET /galleries/1/photos/1/edit
  def edit; end

  # POST /galleries/1/photos
  # POST /galleries/1/photos.json
  def create
    params = create_photo_params
    params[:photo_includes].each do |index|
      i = index.to_i
      # create a photo
      photo = @gallery.photos.new(
        artist: params[:photo_artists][i].blank? ? @gallery.user.name : params[:photo_artists][i],
        caption: params[:photo_captions][i],
        views: 0,
        sequence: i,
        img: params[:photos][i]
      )

      photo.save
      wait 10
    end

    respond_to do |format|
      format.html {
        redirect_to gallery_path(@gallery) }
      format.js   {
        redirect_to gallery_path(@gallery) }
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    if params[:remove]
      params[:remove].each_key do |key|
        @photo = Photo.find(key)
        @photo.remove_source
        @photo.destroy
      end
    end
    respond_to do |format|
      format.html { redirect_to edit_gallery_path(@gallery), notice: 'photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /galleries/1/photos/add
  # POST /galleries/1/photos/add.xml
  def add
    sequence = 0
    if params[:file_names]
      params[:file_names].each do |val|
        p = @gallery.photos.new
        p.img = val.strip
        p.caption = val.strip
        p.views = 0
        p.artist = params[:artist] if params[:artist]
        p.sequence = sequence += 1
        p.save
      end
    end

    respond_to do |format|
      format.html { redirect_to(new_gallery_photo_path(@gallery)) }
      format.xml  { head :ok }
    end
  end

  # POST /photos/increment
  def increment
    @gallery = Gallery.where('code = ?', params[:gallery]).first
    @photo = @gallery.photos.where('img = ?', params[:photo]).first
    @photo.increment
    render nothing: true
  end

  # non-restfull inline editors
  def update_field
    photo = Photo.find(params[:id])
    photo.update(params[:field], params[:value])
    render(text: params[:value])
  end
  # end non-restfull inline editors

  private

  def set_photo
    @photo = Photo.find(params[:id])
    @gallery = @photo.gallery
  end

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end

  def photo_params
    params.require(:photo).permit(:artist, :caption, :views)
  end

  def create_photo_params
    params.permit(photos: [], photo_names: [], photo_includes: [], photo_artists: [], photo_captions: [])
  end
end
