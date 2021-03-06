# users
adam = User.create(
  name: 'adam',
  email: 'adam@raceweb.ca',
  password: 'pass',
  password_confirmation: 'pass',
  # admin, user
  authority: 3
)

# galleries
youth = Gallery.create(
  name: 'welcome to canada (private)',
  code: '19710501',
  private_key: '123123123a',
  user: adam,
  gallery_on: Time.zone.local(2010, 6, 3)
)

victoria_at_night = Gallery.create(
  name: 'victoria at night (public)',
  code: '20090303',
  user: adam,
  gallery_on: Time.zone.local(2010, 6, 2)
)

summer = Gallery.create(
  name: '2010 summer (public)',
  code: '20100501',
  user: adam,
  gallery_on: Time.zone.local(2010, 6, 1)
)

photos = [
  {
    gallery: youth,
    artist: 'mom',
    img: '19700501-001.jpg',
    sequence: 1,
    views: 1,
    caption: 'me and dad on the lawn',
    photo_at: Time.zone.local(1970, 4, 1, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'old pentax'
  }, {
    gallery: youth,
    artist: 'mom',
    img: '19710101-002.jpg',
    sequence: 2,
    views: 13,
    caption: 'drinking breakfast',
    photo_at: Time.zone.local(1970, 7, 1, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'old pentax'
  }, {
    gallery: youth,
    artist: 'dad',
    img: '19710401-001.jpg',
    sequence: 3,
    views: 22,
    caption: 'me and mom on the beach',
    photo_at: Time.zone.local(1971, 4, 1, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'old pentax'
  }, {
    gallery: youth,
    artist: 'dad',
    img: '19710501-002.jpg',
    sequence: 4,
    views: 0,
    caption: 'me at a crossroads',
    photo_at: Time.zone.local(1971, 4, 1, 14, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'old pentax'
  }, {
    gallery: youth,
    img: '19710501-003.jpg',
    sequence: 5,
    views: 10,
    caption: 'all of us by a creek',
    photo_at: Time.zone.local(1971, 5, 1, 10, 30)
  }, {
    gallery: youth,
    artist: 'dad',
    img: '19710501-004.jpg',
    sequence: 6,
    views: 10,
    caption: 'me throwing a rock at the camera',
    photo_at: Time.zone.local(1971, 5, 1, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-001.jpg',
    sequence: 1,
    views: 10,
    caption: 'fountain behind the legislature 1',
    photo_at: Time.zone.local(2009, 3, 3, 22, 30),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-002.jpg',
    sequence: 2,
    views: 10,
    caption: 'roof of the empress',
    photo_at: Time.zone.local(2009, 3, 3, 22, 10),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    exposure_mode: nil,
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-003.jpg',
    sequence: 3,
    views: 10,
    caption: 'legislature',
    photo_at: Time.zone.local(2009, 3, 3, 22, 20),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    exposure_mode: nil,
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-004.jpg',
    sequence: 4,
    views: 10,
    caption: 'lights on government street',
    photo_at: Time.zone.local(2009, 3, 3, 22, 30),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-005.jpg',
    sequence: 5,
    views: 10,
    caption: 'empress hotel',
    photo_at: Time.zone.local(2009, 3, 3, 22, 40),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-006.jpg',
    sequence: 6,
    views: 10,
    caption: 'bastion square',
    photo_at: Time.zone.local(2009, 3, 3, 22, 50),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-007.jpg',
    sequence: 7,
    views: 10,
    caption: 'fountain behind the legislature 2',
    photo_at: Time.zone.local(2009, 3, 3, 23, 0),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: victoria_at_night,
    artist: 'adam',
    img: '20090303-008.jpg',
    sequence: 8,
    views: 10,
    caption: 'fountain behind the legislature 3',
    photo_at: Time.zone.local(2009, 3, 3, 23, 10),
    shutter_speed: '4',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '1200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100516-018.jpg',
    sequence: 2,
    views: 12,
    caption: 'quinn riding through a swamp',
    photo_at: Time.zone.local(2010, 5, 16, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100530-010.jpg',
    sequence: 3,
    views: 3,
    caption: 'else at bastion square',
    photo_at: Time.zone.local(2010, 5, 1, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100606-012.jpg',
    sequence: 4,
    views: 3,
    caption: 'quinn\'s new guitar',
    photo_at: Time.zone.local(2010, 6, 6, 10, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '10.5mm',
    iso: '400',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100606-011.jpg',
    sequence: 5,
    views: 0,
    caption: 'market square',
    photo_at: Time.zone.local(2010, 6, 6, 18, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100501-007.jpg',
    sequence: 6,
    views: 9,
    caption: 'at thetis main beach',
    photo_at: Time.zone.local(2010, 6, 8, 12, 30),
    shutter_speed: '1/200',
    aperture: '1.8',
    focal_length: '50mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100611-004.jpg',
    sequence: 7,
    views: 0,
    caption: 'fireworks',
    photo_at: Time.zone.local(2010, 6, 11, 22, 30),
    shutter_speed: '1/20',
    aperture: '1.8',
    focal_length: '150mm',
    iso: '1600',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }, {
    gallery: summer,
    artist: 'adam',
    img: '20100612-017.jpg',
    sequence: 8,
    views: 88,
    caption: 'snow birds',
    photo_at: Time.zone.local(2010, 6, 12, 13, 30),
    shutter_speed: '1/200',
    aperture: '3.5',
    focal_length: '400mm',
    iso: '200',
    flash: 'off',
    exposure_compensation: '0',
    camera_model: 'nikon d80'
  }
]

photos.each do |photo_attributes|
  image_file = photo_attributes[:img]
  photo_attributes[:img] = nil
  photo = Photo.new(photo_attributes)
  # binding.pry
  File.open(Rails.root.join("db/seeds/#{photo.gallery.code}/#{image_file}")) { |f| photo.img = f }
  photo.save
end

# gallery default photos
youth.default_photo = youth.photos.where(caption: 'me at a crossroads').first
youth.save
victoria_at_night.default_photo = victoria_at_night.photos.where(caption: 'fountain behind the legislature 3').first
victoria_at_night.save
summer.default_photo = summer.photos.where(caption: 'snow birds').first
summer.save

_comment1 = Photo.last.comments.create(message: 'comment 1')
_comment2 = Photo.last.comments.create(message: 'comment 2')
