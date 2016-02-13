class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :mark]

  # Pt 3a Mark action
  # def mark
  #   @request.done = !@request.done
  #   @request.save
  #   redirect_to requests_path  
  # end

  # GET /requests
  # GET /requests.json
  def index
    # Pt 5 add paging
    if params[:search]
      @requests = Request.search(params[:search]).order("done ASC").page(params[:page]).per(7)
    else
      @requests = Request.order("done ASC").page(params[:page]).per(7)
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    # Pt 3b All new Support Request must be marked as "Not Done"
    # refactored to model
    # @request.done = false

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to update_success_direction(@request), notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:name, :email, :department, :message, :done) #done
    end

    def update_success_direction(req)
        if request_params.has_key?(:done)
          requests_path
        else  
          req
        end
    end
end
