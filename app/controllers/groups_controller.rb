class GroupsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_group!
  def load_group!
    @group = current_user.groups.includes(:sensors).where(id: params[:id]).first
    raise ActiveRecord::NotFound if @group.nil?
  end

  def show; end

end
