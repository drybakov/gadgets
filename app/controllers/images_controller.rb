class ImagesController < ApplicationController

  before_action :authenticate_user!

  def new
    @gadget = current_user.gadgets.find(params[:gadget_id])
    @image =  @gadget.images.new
  end

  def create
    @gadget = current_user.gadgets.find(params[:gadget_id])
    @image = @gadget.images.new(image_params)
    if @image.save
      redirect_to gadgets_path
    else
      render :new
    end
  end

  private

  def image_params
    params.require(:image).permit!
  end

end