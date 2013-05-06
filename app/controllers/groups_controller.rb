class GroupsController < ApplicationController
  before_filter :authenticate_user!
  # GET /groups
  # GET /groups.json
 
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group.user_ids.push(current_user.email)
    current_user.group_ids.push(@group.id.to_s)
    current_user.save
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def adduser
  @group = Group.find(params[:id])
  if (@group.user_ids.include?(params[:user]))
  else  
  @group.user_ids.push(params[:user])

  if params[:user].include? "@"
     @user = User.where(:email => params[:user]).first
  else
     @user = User.where(:userid => params[:user]).first
  end

  if @user
    if @user.group_ids.include?(params[:id])
    else  
      @user.group_ids.push(params[:id])
    end
  end
  end
  respond_to do |format|
    if (@user == nil)
      format.html { redirect_to @group, notice: 'Sorry, not a valid email or userid' }
    else  
    if (@user.save && @group.save)
        format.html { redirect_to @group, notice: 'User added to group' }
        format.json { head :no_content }
      else
        format.html { redirect_to @group, notice: 'User not added to group' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
  end
end
end

  def removeuser
    @group = Group.find(params[:id])
    @group.user_ids.delete(params[:user])
    @group.save

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
end
