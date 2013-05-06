
class TestudosController < ApplicationController
  # GET /testudos
  # GET /testudos.json
  def index
    @testudos = Testudo.sort(:classid)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @testudos }
    end
  end

  # GET /testudos/1
  # GET /testudos/1.json
  def show
    @testudo = Testudo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @testudo }
    end
  end

  # GET /testudos/new
  # GET /testudos/new.json
  def new
    @testudo = Testudo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @testudo }
    end
  end

  # GET /testudos/1/edit
  def edit
    @testudo = Testudo.find(params[:id])
  end

  # POST /testudos
  # POST /testudos.json
  def create
    @testudo = Testudo.new(params[:testudo])

    respond_to do |format|
      if @testudo.save
        format.html { redirect_to @testudo, notice: 'Testudo was successfully created.' }
        format.json { render json: @testudo, status: :created, location: @testudo }
      else
        format.html { render action: "new" }
        format.json { render json: @testudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /testudos/1
  # PUT /testudos/1.json
  def update
    @testudo = Testudo.find(params[:id])

    respond_to do |format|
      if @testudo.update_attributes(params[:testudo])
        format.html { redirect_to @testudo, notice: 'Testudo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @testudo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testudos/1
  # DELETE /testudos/1.json
  def destroy
    @testudo = Testudo.find(params[:id])
    @testudo.destroy

    respond_to do |format|
      format.html { redirect_to testudos_url }
      format.json { head :no_content }
    end
  end
end
