class HostgroupsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        @search     = Hostgroup.search params[:search]
        @hostgroups = @search.paginate :page => params[:page]
      end
      format.json { render :json => Hostgroup.all }
    end
  end

  def new
    @hostgroup = Hostgroup.new
  end

  def show
    @hostgroup = Hostgroup.find(params[:id])
    respond_to do |format|
      format.json { render :json => @hostgroup }
    end
  end

  def create
    @hostgroup = Hostgroup.new(params[:hostgroup])
    if @hostgroup.save
      notice "Successfully created hostgroup."
      redirect_to hostgroups_url
    else
      render :action => 'new'
    end
  end

  def edit
    @hostgroup = Hostgroup.find(params[:id])
  end

  def update
    @hostgroup = Hostgroup.find(params[:id])
    if @hostgroup.update_attributes(params[:hostgroup])
      notice "Successfully updated hostgroup."
      redirect_to hostgroups_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @hostgroup = Hostgroup.find(params[:id])
    if @hostgroup.destroy
      notice "Successfully destroyed hostgroup."
    else
      error @template.truncate @hostgroup.errors.full_messages.join("<br/>"), 80
    end
    redirect_to hostgroups_url
  end
end
