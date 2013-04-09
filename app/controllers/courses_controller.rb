class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def getUserSchedule()
    return current_user.schedule
  end  

  def index
    @courses = getUserSchedule().courses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = getUserSchedule().courses[params[:id].to_i]

    respond_to do |format|
      format.html # show.html.format
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = getUserSchedule().courses[params[:id].to_i]
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    getUserSchedule().courses.push(@course)
    respond_to do |format|
      if @course.save
        format.html { redirect_to getUserSchedule(), notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    index = params[:id]
    @course = getUserSchedule().courses[params[:id].to_i]

    respond_to do |format|
      if true
        format.html { redirect_to getUserSchedule(), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    getUserSchedule().courses.delete_at((params[:id].to_i))
    current_user.save

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end
end
