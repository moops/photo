class GalleriesController < ApplicationController

  load_and_authorize_resource

  # GET /galleries
  # GET /galleries.xml
  def index
    # searching by private key
    if params[:key]
      @gallery = Gallery.find_by_private_key(params[:key])
      if @gallery.nil?
        flash[:notice] = "no gallery found"
      else
        redirect_to gallery_path(@gallery)
        return
      end
    end
    
    # searching public galleries by name and/or date
    if params[:name] or params[:gallery_on]
      @search_results = Gallery.find_public(params[:name],params[:gallery_on])
    end
    
    @recent_galleries = Gallery.recent_galleries

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galleries }
    end
  end

  # GET /galleries/1
  # GET /galleries/1.xml
  def show
    @photos = @gallery.photos
    if @gallery.default_photo 
      @photo = Photo.find_by_img(@gallery.default_photo)
    else
      @photo = @photos.to_a[0]
    end
    index = @photos.index(@photo) || 0
    @next = @photos[index + 1].id if index < @photos.length - 1
    @prev = @photos[index - 1].id if index > 0

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/new
  # GET /galleries/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gallery }
    end
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  # POST /galleries.xml
  def create
    
    #generate private key
    if 'private'.eql?(params[:gallery_access])
      chars = ("a".."z").to_a + ("1".."9").to_a
      key = Array.new(20, '').collect{chars[rand(chars.size)]}.join
      @gallery.private_key=(key)
    end

    respond_to do |format|
      if @gallery.save
        flash[:notice] = "#{@gallery.name} was successfully created."
        format.html { redirect_to(new_gallery_photo_path(@gallery)) }
        format.xml  { render :xml => @gallery, :status => :created, :location => @gallery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galleries/1
  # PUT /galleries/1.xml
  def update

    respond_to do |format|
      if @gallery.update_attributes(params[:gallery])
        flash[:notice] = 'Gallery was successfully updated.'
        format.html { redirect_to(edit_gallery_path(@gallery)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gallery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.xml
  def destroy
    @gallery.destroy

    respond_to do |format|
      format.html { redirect_to(galleries_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def find_photos(use_default)
      @photos = Photo.find(:all, 
                           :conditions => ["gallery_id = ?", @gallery],
                           :order => session[:gallery_view_mode])
      if use_default
        if @gallery.default_photo 
          @photo = Photo.find_by_img(@gallery.default_photo)
        else
          @photo = @photos.to_a[0]
        end
      end
      index = @photos.index(@photo)
      @next = @photos[index + 1].id if index < @photos.length - 1
      @prev = @photos[index - 1].id if index > 0
      # @photo.set_exif
    end
end
