require_relative '../models/user'

class HeadquartersController < ApplicationController
  # GET /headquarters
  # GET /headquarters.json
  def index
    @headquarters = Headquarter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @headquarters }
    end
  end

  # GET /headquarters/1
  # GET /headquarters/1.json
  def show
    @headquarter = Headquarter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @headquarter }
    end
  end

  # GET /headquarters/new
  # GET /headquarters/new.json
  def new
    @headquarter = Headquarter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @headquarter }
    end
  end

  # GET /headquarters/1/edit
  def edit
    @headquarter = Headquarter.find(params[:id])
  end

  # POST /headquarters
  # POST /headquarters.json
  def create
    @headquarter = Headquarter.new(params[:headquarter])

    respond_to do |format|
      if @headquarter.save
        format.html { redirect_to @headquarter, notice: 'Headquarter was successfully created.' }
        format.json { render json: @headquarter, status: :created, location: @headquarter }
      else
        format.html { render action: "new" }
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /headquarters/1
  # PUT /headquarters/1.json
  def update
    @headquarter = Headquarter.find(params[:id])

    respond_to do |format|
      if @headquarter.update_attributes(params[:headquarter])
        format.html { redirect_to @headquarter, notice: 'Headquarter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @headquarter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /headquarters/1
  # DELETE /headquarters/1.json
  def destroy
    @headquarter = Headquarter.find(params[:id])
    @headquarter.destroy

    respond_to do |format|
      format.html { redirect_to headquarters_url }
      format.json { head :no_content }
    end
  end
end
