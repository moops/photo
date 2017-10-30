class GalleriesController < ApplicationController
  before_action :set_gallery, only: %i[show edit update destroy count]

  # GET /posts
  # GET /posts.json
  def index
    @galleries = policy_scope(Gallery).page(params[:page]).per(6)
    if params[:q]
      # searching
      @gallery = Gallery.find_private(params[:q])
      unless @gallery.nil?
        redirect_to gallery_path(@gallery)
        return
      end
      @galleries = Gallery.find_public(params[:q]).page(params[:page]).per(6) if @gallery.nil?
    else
      if current_user
        @galleries = current_user.galleries.order('gallery_on desc').page(params[:page]).per(6)
      else
        @galleries = nil
      end
    end

    @recent_galleries = Gallery.public_recent.all
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    unless @gallery
      redirect_to root_path, notice: 'no gallery found'
      return
    end
    authorize @gallery unless params[:private_key]
    @photos = @gallery.photos
    if @photos.blank?
      redirect_to new_gallery_photo_path(@gallery)
      return
    end
    @photo = @gallery.default_photo
  end

  # GET /posts/new
  def new
    @gallery = Gallery.new
  end

  # GET /posts/1/edit
  def edit
    authorize @gallery
  end

  # GET /posts/1/count.json
  def count
    authorize @gallery
    # @count = @gallery.photo_count
    render json: { gallery_id: @gallery.id, count: @gallery.photo_count }
  end

  # POST /posts
  # POST /posts.json
  def create
    @gallery = Gallery.new(gallery_params)
    @gallery.private_key = Gallery.new_private_key(gallery_params[:private_key])
    @gallery.gallery_on = Time.zone.today if gallery_params[:gallery_on].empty?
    @gallery.user = current_user if current_user

    respond_to do |format|
      if @gallery.save
        format.html { redirect_to new_gallery_photo_path(@gallery), notice: "#{@gallery.name} was successfully created." }
        format.js   { redirect_to new_gallery_photo_path(@gallery, format: :html) }
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
      format.html { redirect_to root_url, notice: "gallery \"#{@gallery.name}\" was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_gallery
    if params[:private_key]
      @gallery = Gallery.find_by(private_key: params[:private_key])
      return
    end
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :code, :private_key, :user_id, :gallery_on, :default_photo_id)
  end
end
