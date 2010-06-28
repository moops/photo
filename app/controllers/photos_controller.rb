class PhotosController < ApplicationController

  layout 'standard'
  before_filter :get_gallery
  
  def get_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end
  
  # GET /galleries/1/photos
  # GET /galleries/1/photos.xml
  def index
    @photo = Photo.new
    @photos = @gallery.photos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /galleries/1/photos/1
  # GET /galleries/1/photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /galleries/1/photos/new
  # GET /galleries/1/photos/new.xml
  def new
    @photo = @gallery.photos.new
    logger.info("creating photo #{@photo.inspect}")
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /galleries/1/photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /galleries/1/photos
  # POST /galleries/1/photos.xml
  def create
    @photo = @gallery.photos.new
    @photo.artist=(params[:photo]['artist'])
    @photo.caption=(params[:photo]['caption'])
    source = params[:photo]['source']
    logger.info("creating photo: #{@photo.inspect}")
    logger.info("with file: #{source.inspect}")
    @photo.save_source(source)
    @photo.filename=(source.original_filename)
    
    respond_to do |format|
      if @photo.save
        flash[:notice] = "#{@photo.filename} was successfully created."
        format.html { redirect_to(new_gallery_photo_path(@gallery)) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1/photos/1
  # PUT /galleries/1/photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
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
  
end
