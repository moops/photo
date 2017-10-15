class GalleriesController < ApplicationController
  before_action :set_gallery, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @galleries = policy_scope(Gallery).page(params[:page]).per(6)
    # if params[:q]
    #   # searching
    #   @gallery = Gallery.find_private(params[:q])
    #   unless @gallery.nil?
    #     redirect_to gallery_path(@gallery)
    #     return
    #   end
    #   @galleries = Gallery.find_public(params[:q]).page(params[:page]).per(6) if @gallery.nil?
    # else
    #   if current_user
    #     @galleries = current_user.galleries.order('gallery_on desc').page(params[:page]).per(6)
    #   else
    #     @galleries = nil
    #   end
    # end

    @recent_galleries = Gallery.public_recent
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    authorize @gallery
    @photos = @gallery.photos
    @photo = @gallery.default_photo_obj
  end

  # GET /posts/new
  def new
    @gallery = Gallery.new
  end

  # GET /posts/1/edit
  def edit
    authorize @gallery
  end

  # POST /posts
  # POST /posts.json
  def create
    @gallery = Gallery.new(gallery_params)

    # generate private key
    if "1".eql? gallery_params[:private_key]
      chars = ("a".."z").to_a + ("1".."9").to_a
      key = Array.new(20, '').collect{chars[rand(chars.size)]}.join
      @gallery.private_key = key
    else
      @gallery.private_key = nil
    end

    @gallery.user = current_user if current_user

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to new_gallery_photo_path(@gallery), notice: "#{@gallery.name} was successfully created." }
        format.json { render :show, status: :created, location: @gallery }
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # def find_photos(use_default)
    #   @photos = Photo.find(:all,
    #                        :conditions => ["gallery_id = ?", @gallery],
    #                        :order => session[:gallery_view_mode])
    #   if use_default
    #     if @gallery.default_photo
    #       @photo = Photo.find_by_img(@gallery.default_photo)
    #     else
    #       @photo = @photos.to_a[0]
    #     end
    #   end
    #   index = @photos.index(@photo)
    #   @next = @photos[index + 1].id if index < @photos.length - 1
    #   @prev = @photos[index - 1].id if index > 0
    #   # @photo.set_exif
    # end

    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:name, :code, :private_key, :user_id, :gallery_on, :default_photo)
    end
end
