class MicropostsController < ApplicationController
  before_action :set_micropost, only: %i[ show edit update destroy check_user]
  before_action :authenticate_user!, only: [:edit, :update, :create, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  # GET /microposts or /microposts.json
  def index
    @microposts = Micropost.order(created_at: :desc)
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
        @micropost.photos.create!(picture: micropost_params[:photo], micropost_id: @micropost.id, user_id: current_user.id)
        format.html { redirect_to micropost_url(@micropost), notice: "Micropost was successfully created." }
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
      if @micropost.update(micropost_params)
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

  def check_user
    if current_user != @micropost.user
      redirect_to :root
      flash[:notice] = "Finger weg!"
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

end
