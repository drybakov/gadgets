class GadgetsController < ApplicationController

  before_action :authenticate_user!

  def index
    @gadgets = current_user.gadgets
    if params[:style] == 'cover'
      render :index_cover
    else
      render :index_list
    end
  end

  def new
    @gadget = current_user.gadgets.new
  end

  def create
    @gadget = current_user.gadgets.new(gadget_params)
    if @gadget.save
      redirect_to gadgets_path
    else
      render :new
    end
  end

  private

  def gadget_params
    params.require(:gadget).permit(:name, :description)
  end
end