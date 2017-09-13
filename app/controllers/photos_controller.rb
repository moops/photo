class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource :gallery, :except => :increment
  # load_and_authorize_resource :photo, :through => :gallery, :except => :increment

  # skip_authorize_resource :only => :increment
  # skip_authorize_resource :gallery, :only => :increment

  # GET /galleries/1/photos
  # GET /galleries/1/photos.xml
  def index
    @photos = @gallery.photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @photos }
    end
  end

  # GET /galleries/1/photos/1
  # GET /galleries/1/photos/1.js
  def show
    index = @gallery.photos.index(@photo)
    @next = @gallery.photos[index + 1].id if index < @gallery.photos.length - 1
    @prev = @gallery.photos[index - 1].id if index > 0

    unless (params[:exif])
      @photo.views += 1
      @photo.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js   {
        if params[:exif]
          render 'exif'
        else
          render 'show'
        end
      }
    end
  end

  # GET /galleries/1/photos/new
  # GET /galleries/1/photos/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /galleries/1/photos/1/edit
  def edit
  end

  # POST /galleries/1/photos
  # POST /galleries/1/photos.json
  def create
    #@photo.artist=(params[:photo]['artist'])
    #@photo.caption=(params[:photo]['caption'])
    #source = params[:photo][:img].tempfile
    #logger.info("create params: #{source.inspect}")
    #@photo.extract_exif(source)
    #@photo.save_source(source)
    #@photo.img=(source.original_filename)
    @photo.views = 0

    respond_to do |format|
      if @photo.save
        format.json { render json: [ @photo.to_jq_upload ].to_json }
      else
        format.json { render json: [ @photo.to_jq_upload.merge({ error: "custom_failure" }) ].to_json }
      end
    end
  end

  # PUT /galleries/1/photos/1
  # PUT /galleries/1/photos/1.xml
  def update

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /galleries/1/photos/remove
  # POST /galleries/1/photos/remove.xml
  def remove

    if params[:remove]
      params[:remove].each do |key,val|
        @photo = Photo.find(key)
        @photo.remove_source
        @photo.destroy
      end
    end

    respond_to do |format|
      format.html { redirect_to(edit_gallery_path(@gallery)) }
      format.xml  { head :ok }
    end
  end

  # POST /galleries/1/photos/add
  # POST /galleries/1/photos/add.xml
  def add
    sequence = 0
    if params[:file_names]
      params[:file_names].each do |val|
        p = @gallery.photos.new
        p.img= val.strip
        p.caption= val.strip
        p.views = 0
        p.artist= params[:artist] if (params[:artist])
        p.sequence= sequence += 1
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
    photo.update_attribute(params[:field], params[:value])
    render(text: params[:value])
  end
  # end non-restfull inline editors

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end

    def photo_params
      params.require(:photo).permit(:artist, :caption, :views)
    end

end
