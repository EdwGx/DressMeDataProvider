class ClothesController < ApplicationController
  before_action :set_clothe, only: [:show, :edit, :update, :destroy]

  # GET /clothes
  # GET /clothes.json
  def index
    @clothes = Clothe.all
  end

  # GET /clothes/1
  # GET /clothes/1.json
  def show
  end

  # GET /clothes/new
  def new
    @clothe = Clothe.new
  end

  # GET /clothes/1/edit
  def edit
  end

  # POST /clothes
  # POST /clothes.json
  def create
    @clothe = Clothe.new(clothe_params)

    respond_to do |format|
      if @clothe.save
        format.html { redirect_to @clothe, notice: 'Clothe was successfully created.' }
        format.json { render :show, status: :created, location: @clothe }
      else
        format.html { render :new }
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clothes/1
  # PATCH/PUT /clothes/1.json
  def update
    respond_to do |format|
      if @clothe.update(clothe_params)
        format.html { redirect_to @clothe, notice: 'Clothe was successfully updated.' }
        format.json { render :show, status: :ok, location: @clothe }
      else
        format.html { render :edit }
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clothes/1
  # DELETE /clothes/1.json
  def destroy
    @clothe.destroy
    respond_to do |format|
      format.html { redirect_to clothes_url, notice: 'Clothe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clothe
      @clothe = Clothe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clothe_params
      params.require(:clothe).permit(:article_id, :color_id, :raw_description, :score)
    end
end
