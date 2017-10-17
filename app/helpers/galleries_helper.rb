module GalleriesHelper
  def default_photo(gallery)
    return content_tag(:span, nil, { class: ['icon-camera', 'empty-gallery-icon'] }, false) if gallery.photos.empty?
    return image_tag(gallery.default_photo_obj.img_url(:thumb))
  end
end
