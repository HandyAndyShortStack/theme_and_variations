class ShowImageBlock < Block

  def image
    return nil unless self.image_id
    Image.find(self.image_id) 
  end

  def image_link
    if link_str = options["image_link"]
      link_str.blank? ? nil : link_str
    else
      nil
    end
  end

  def image_size
    options["image_size"].to_sym || :original
  end

  def image_url
    return "http://lorempixel.com/400/200/" unless image
    versions = image.asset.versions.keys
    if versions.include? image_size
      image.asset_url image_size
    else
      image.asset_url
    end
  end
end
