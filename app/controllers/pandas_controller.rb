require 'RMagick'

class PandasController < ApplicationController

  MAX_WIDTH  = 4000
  MAX_HEIGHT = 3000

  before_filter :request_precheck

  def color
    image = PandaPicker.new.get_color_image( @width, @height )
    deliver(image) and return
  end

  def grayscale
    image = PandaPicker.new.get_grayscale_image( @width, @height )
    deliver(image) and return
  end

  protected

  def deliver(image)
    if image == nil
      render :text => "Unknown error occurred", :status => 500
    else
      send_data image.to_blob, :type => 'image/png', :disposition => 'inline'
    end
  end

  def request_precheck

    @width = params[:width].to_i
    @height = params[:height].to_i

    if @width > MAX_WIDTH or @height > MAX_HEIGHT
      return false
    end

    return true
  end
end
