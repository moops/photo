# view helper for galleries_controller
module GalleriesHelper
  def default_photo(gallery)
    return content_tag(:span, nil, { class: ['icon-camera', 'empty-gallery-icon'] }, false) if gallery.photos.empty?
    image_tag(gallery.default_photo_obj.img_url(:thumb))
  end
end
