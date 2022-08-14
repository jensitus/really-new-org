class PhotoGalleriesController < ApplicationController
  before_action :set_photo_gallery, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]

  # GET /photo_galleries or /photo_galleries.json
  def index
    @photo_galleries = PhotoGallery.all
  end

  # GET /photo_galleries/1 or /photo_galleries/1.json
  def show
  end

  # GET /photo_galleries/new
  def new
    @photo_gallery = PhotoGallery.new
  end

  # GET /photo_galleries/1/edit
  def edit
  end

  # POST /photo_galleries or /photo_galleries.json
  def create
    @photo_gallery = current_user.photo_galleries.create!(title: photo_gallery_params[:title], description: photo_gallery_params[:description], last_updated_by_id: current_user.id)

    respond_to do |format|
      if @photo_gallery.save
        puts photo_gallery_params.inspect
        # @photo_gallery.photos.create!(picture: photo_gallery_params[:photo], photo_gallery_id: @photo_gallery.id, user_id: current_user.id)
        # format.html { redirect_to photo_gallery_url(@photo_gallery), notice: "Photo gallery was successfully created." }
        # format.json { render :show, status: :created, location: @photo_gallery }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @photo_gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photo_galleries/1 or /photo_galleries/1.json
  def update
    respond_to do |format|
      if @photo_gallery.photos.create!(picture: photo_gallery_params[:photo], photo_gallery_id: @photo_gallery.id, user_id: current_user.id)
        format.html { redirect_to photo_gallery_url(@photo_gallery), notice: "Photo gallery was successfully updated." }
        format.json { render :show, status: :ok, location: @photo_gallery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo_gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_galleries/1 or /photo_galleries/1.json
  def destroy
    @photo_gallery.destroy

    respond_to do |format|
      format.html { redirect_to photo_galleries_url, notice: "Photo gallery was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo_gallery
      @photo_gallery = PhotoGallery.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_gallery_params
      params.require(:photo_gallery).permit(:title, :description, :last_updated_by_id, :photo)
    end
end
