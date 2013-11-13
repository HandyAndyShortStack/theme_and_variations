class SlideshowBlock < Block
  
  def image_ids
    options["image_ids"] || []
  end

  def images
    Image.find(image_ids)
  end
end
