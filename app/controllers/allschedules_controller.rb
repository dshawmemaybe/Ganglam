class AllschedulesController < ApplicationController
  # GET /allschedules
  # GET /allschedules.json
  def index
    @allschedules = Allschedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @allschedules }
    end
  end

  # GET /allschedules/1
  # GET /allschedules/1.json
  def show
    @allschedule = Allschedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @allschedule }
    end
  end

  # GET /allschedules/new
  # GET /allschedules/new.json
  def new
    @allschedule = Allschedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @allschedule }
    end
  end

  # GET /allschedules/1/edit
  def edit
    @allschedule = Allschedule.find(params[:id])
  end

  # POST /allschedules
  # POST /allschedules.json
  def create
    @allschedule = Allschedule.new(params[:allschedule])

    respond_to do |format|
      if @allschedule.save
        format.html { redirect_to @allschedule, notice: 'Allschedule was successfully created.' }
        format.json { render json: @allschedule, status: :created, location: @allschedule }
      else
        format.html { render action: "new" }
        format.json { render json: @allschedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /allschedules/1
  # PUT /allschedules/1.json
  def update
    @allschedule = Allschedule.find(params[:id])

    respond_to do |format|
      if @allschedule.update_attributes(params[:allschedule])
        format.html { redirect_to @allschedule, notice: 'Allschedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @allschedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allschedules/1
  # DELETE /allschedules/1.json
  def destroy
    @allschedule = Allschedule.find(params[:id])
    @allschedule.destroy

    respond_to do |format|
      format.html { redirect_to allschedules_url }
      format.json { head :no_content }
    end
  end
end
