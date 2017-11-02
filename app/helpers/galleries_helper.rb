# view helper for galleries_controller
module GalleriesHelper
  def default_photo(gallery)
    return content_tag(:span, nil, { class: ['icon-gallery', 'empty-gallery-icon'] }, false) if gallery.photos.blank?
    image_tag(gallery.def_photo&.img_url(:thumb), class: 'thumbnail')
  end
end
