class GalleriesController < ApplicationController

  load_and_authorize_resource

  # GET /galleries
  # GET /galleries.js
  def index
    # searching
    if params[:q]
      @gallery = Gallery.find_private(params[:q])
      unless @gallery.nil?
        redirect_to gallery_path(@gallery)
        return
      end
      @search_results = Gallery.find_public(params[:q]).page(params[:page]).per(6) if @gallery.nil?
    else
      @my_galleries = current_user.galleries.order('gallery_on desc').page(params[:page]).per(6) if current_user
    end

    @recent_galleries = Gallery.public_recent

    respond_to do |format|
      format.html # index.html.erb
      format.js  # index.js.erb
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
    if "1".eql?(params[:gallery][:private_key])
      chars = ("a".."z").to_a + ("1".."9").to_a
      key = Array.new(20, '').collect{chars[rand(chars.size)]}.join
      @gallery.private_key=(key)
    else
      @gallery.private_key=(nil)
    end

    @gallery.user = current_user if current_user

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
