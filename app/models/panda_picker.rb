require 'RMagick'

class PandaPicker
  Pic = Struct.new( :image, :width, :height )

  ###
  # Preload all pictures in the /images directory
  ###
  def self.preload_pics
    puts "Preloading pics"
    start_time = Time.now
    images = []
    dir = Rails.root.join('public', 'assets', 'pandas')
    Dir.entries( dir ).collect{ |f| f if f =~ /\.jpg/ }.compact.each do |pic|
      mag = Magick::Image.read( "#{dir}/#{pic}" ).first
      p = Pic.new( mag, mag.columns, mag.rows )
      images.push p
    end

    puts "#{images.count} images loaded in #{(Time.now - start_time).round(2)} seconds"
    return images
  end

  PICS = preload_pics

  def get_color_image( width, height )
    img = get_random_image

    while( img.columns < width || img.rows < height ) do
      puts 'going for another'
      img = get_random_image
    end

    multiplier = 0.0
    multiplier = get_multiplier( img, width, height )
    img = img.thumbnail( img.columns*multiplier, img.rows*multiplier )
    img = img.crop( Magick::CenterGravity, width, height )
    if img.columns != 1 || img.rows != 1
      return img
    else
      return nil
    end
  end

  def get_grayscale_image( width, height )
    image = get_color_image( width, height )
    image = image.quantize( 256, Magick::GRAYColorspace )
  end

  def get_multiplier( img, width, height )
    height_multiplier = (height.to_f / img.rows).round( 6 )
    width_multiplier =  (width.to_f / img.columns.to_f).round( 6 )

    multiplier = width_multiplier > height_multiplier ? width_multiplier : height_multiplier
    multiplier = multiplier + 0.000002

    multiplier
  end

  def get_random_image
    return PICS[rand(PICS.count)].image
  end
end