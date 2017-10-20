class CommentsController < ApplicationController
  before_action :set_photo, only: %i[index create new]
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /photos/1/comments
  # GET /photos/1/comments.js
  def index
    @comments = @photo.comments.order(created_at: :desc).limit(3)
    @comment = @photo.comments.new
    logger.info('comments.index')
  end

  # GET /comments/1
  # GET /comments/1.json
  def show; end

  # GET /photos/1/comments/new
  # GET /photos/1/comments/new.json
  def new; end

  # GET /comments/1/edit
  def edit; end

  # POST /photos/1/comments
  # POST /photos/1/comments.json
  def create
    @comment = @photo.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js   { redirect_to photo_comments_path(@photo) }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js   { render :index }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    @photo = @comment.photo
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
