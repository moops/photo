# users
adam = User.create(
  name: 'adam',
  email: 'adam@raceweb.ca',
  password: 'pass',
  password_confirmation: 'pass',
  # admin, user
  authority: 3)

# galleries
youth = Gallery.create(
  name: 'welcome to canada (private)',
  code: '19710501',
  private_key: '123123123a',
  user: adam,
  gallery_on: Time.local(2010, 6, 3),
  default_photo: '19710501_5.jpg')

victoria_at_night = Gallery.create(
  name: 'victoria at night (public)',
  code: '20090303',
  user: adam,
  gallery_on: Time.local(2010, 6, 2),
  default_photo: '20090303_8.jpg')

summer = Gallery.create(
  name: '2010 summer (public)',
  code: '20100501',
  user: adam,
  gallery_on: Time.local(2010, 6, 1),
  default_photo: '20100612_8.jpg')

# photos
winter_street = Photo.create(
  gallery: youth,
  artist: 'mom',
  img: '19700401_1.jpg',
  sequence: 1,
  views: 1,
  caption: 'me and dad on the lawn',
  photo_at: Time.local(1970, 04, 01, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'old pentax')

high_chair = Photo.create(
  gallery: youth,
  artist: 'mom',
  img: '19700701_2.jpg',
  sequence: 2,
  views: 13,
  caption: 'drinking breakfast',
  photo_at: Time.local(1970, 07, 01, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'old pentax')
    
beach = Photo.create(
  gallery: youth,
  artist: 'dad',
  img: '19710401_3.jpg',
  sequence: 3,
  views: 22,
  caption: 'me and mom on the beach',
  photo_at: Time.local(1971, 04, 01, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'old pentax')
  
clown_pants = Photo.create(
  gallery: youth,
  artist: 'dad',
  img: '19710401_4.jpg',
  sequence: 4,
  views: 0,
  caption: 'me at a crossroads',
  photo_at: Time.local(1971, 04, 01, 14, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'old pentax')
  
by_the_creek = Photo.create(
  gallery: youth,
  img: '19710501_01.jpg',
  sequence: 5,
  views: 10,
  caption: 'all of us by a creek',
  photo_at: Time.local(1971, 05, 01, 10, 30))
  
throwing_a_rock = Photo.create(
  gallery: youth,
  artist: 'dad',
  img: '19710501_5.jpg',
  sequence: 6,
  views: 10,
  caption: 'me throwing a rock at the camera',
  photo_at: Time.local(1971, 05, 01, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')

night_bear = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_25.jpg',
  sequence: 1,
  views: 10,
  caption: 'fountain behind the legislature',
  photo_at: Time.local(2009, 03, 03, 22, 30),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_empress_roof = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_27.jpg',
  sequence: 2,
  views: 10,
  caption: 'roof of the empress',
  photo_at: Time.local(2009, 03, 03, 22, 10),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  exposure_mode: nil,
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_legislature = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_32.jpg',
  sequence: 3,
  views: 10,
  caption: 'legislature',
  photo_at: Time.local(2009, 03, 03, 22, 20),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  exposure_mode: nil,
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_lights_on_government = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_40.jpg',
  sequence: 4,
  views: 10,
  caption: 'lights on government street',
  photo_at: Time.local(2009, 03, 03, 22, 30),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_empress = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_44.jpg',
  sequence: 5,
  views: 10,
  caption: 'empress hotel',
  photo_at: Time.local(2009, 03, 03, 22, 40),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_bastion = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_49.jpg',
  sequence: 6,
  views: 10,
  caption: 'bastion square',
  photo_at: Time.local(2009, 03, 03, 22, 50),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_fountain_1 = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_5.jpg',
  sequence: 7,
  views: 10,
  caption: 'fountain behind the legislature',
  photo_at: Time.local(2009, 03, 03, 23, 00),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
night_fountain_2 = Photo.create(
  gallery: victoria_at_night,
  artist: 'adam',
  img: '20090303_8.jpg',
  sequence: 8,
  views: 10,
  caption: 'fountain behind the legislature',
  photo_at: Time.local(2009, 03, 03, 23, 10),
  shutter_speed: '4',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '1200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')

summer_quinn_riding = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100516_7.jpg',
  sequence: 2,
  views: 12,
  caption: 'quinn riding through a swamp',
  photo_at: Time.local(2010, 05, 16, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')

summer_bastion_else = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100530_9.jpg',
  sequence: 3,
  views: 3,
  caption: 'else at bastion square',
  photo_at: Time.local(2010, 05, 01, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
summer_guitar = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100606_9.jpg',
  sequence: 4,
  views: 3,
  caption: 'quinn\'s new guitar',
  photo_at: Time.local(2010, 06, 06, 10, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '10.5mm',
  iso: '400',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
summer_market_square_both = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100606_20.jpg',
  sequence: 5,
  views: 0,
  caption: 'market square',
  photo_at: Time.local(2010, 06, 06, 18, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80 ')
  
summer_else_thetis = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100608_16.jpg',
  sequence: 6,
  views: 9,
  caption: 'at thetis main beach',
  photo_at: Time.local(2010, 6, 8, 12, 30),
  shutter_speed: '1/200',
  aperture: '1.8',
  focal_length: '50mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
summer_fireworks = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100611_12.jpg',
  sequence: 7,
  caption: 'fireworks',
  photo_at: Time.local(2010, 06, 11, 22, 30),
  shutter_speed: '1/20',
  aperture: '1.8',
  focal_length: '150mm',
  iso: '1600',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
  
summer_snowbirds = Photo.create(
  gallery: summer,
  artist: 'adam',
  img: '20100612_15.jpg',
  sequence: 8,
  views: 88,
  caption: 'snow birds',
  photo_at: Time.local(2010, 06, 12, 13, 30),
  shutter_speed: '1/200',
  aperture: '3.5',
  focal_length: '400mm',
  iso: '200',
  flash: 'off',
  exposure_compensation: '0',
  camera_model: 'nikon d80')
