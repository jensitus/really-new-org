class MicropostsController < ApplicationController
  before_action :set_micropost, only: %i[ show edit update destroy check_user]
  before_action :authenticate_user!, only: [:new, :edit, :update, :create, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /microposts or /microposts.json
  def index
    @microposts = Micropost.paginate(page: params[:page], per_page: 10).order('updated_at desc')
    if current_user
      @gallery_titles = current_user.photo_galleries.select(:id, :title)
    end

    # # # this is for futue pagination: # # #
    # @count = Micropost.all.count
    # if params[:limit].nil? && params[:offset].nil?
    #   @microposts = Micropost.paginated(5, 0);
    # else
    #   @microposts = Micropost.paginated(params[:limit], params[:offset])
    # end
    # # # # # # # #

  end

  # GET /microposts/1 or /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts or /microposts.json
  def create
    @micropost = current_user.microposts.build(content: micropost_params[:content])
    respond_to do |format|
      if @micropost.save
        unless micropost_params[:photo].nil?
          @micropost.photos.create!(picture: micropost_params[:photo], micropost_id: @micropost.id, user_id: current_user.id)
        end
        format.html { redirect_to micropost_url(@micropost), notice: "post was successfully created." }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1 or /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(content: micropost_params[:content])
        if micropost_params[:photo]
          @micropost.photos.each do |photo|
            photo.update picture: micropost_params[:photo]
          end
        end
        format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully updated." }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1 or /microposts/1.json
  def destroy
    @micropost.destroy

    respond_to do |format|
      format.html { redirect_to microposts_url, notice: "Micropost was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_micropost
    begin
      @micropost = Micropost.find(params[:id])
    rescue => e
      redirect_to :root
    end
  end

  # Only allow a list of trusted parameters through.
  def micropost_params
    params.require(:micropost).permit(:content, :user_id, :photo) # photo_attributes: [:id, :micropost_id, :picture])
  end

  def check_user
    if current_user != @micropost.user
      redirect_to :root
      flash[:notice] = "Finger weg!"
    end
  end

end
