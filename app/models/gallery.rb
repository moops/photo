class Gallery < ActiveRecord::Base

  has_many :photos
  
  validates_uniqueness_of :code

  def self.recent_galleries
    Gallery.find(:all,
                 :conditions => ['private_key is null'],
                 :order => 'gallery_on desc',
                 :limit => 6)
  end
               
  def self.find_public(name,gallery_on)
    findSql = 'private_key is null and name like ?'
    find_conditions = [findSql,"%#{name}%"]
    unless gallery_on.empty?
      findSql += ' and gallery_on = ?'
      find_conditions[0] = findSql
      find_conditions << gallery_on
    end
    logger.debug("find conditions[#{find_conditions.inspect}]")
    Gallery.paginate :page => 1, :conditions => find_conditions, :order => 'name', :per_page => 10
  end

  def self.find_private
    Gallery.find(:first, :conditions => ['private_key = ?',private_key])
  end

  def photo_count
    photos.size
  end
  
  def photo_attributes=(photo_attributes)
    photo_attributes.each do |attributes|
      photos.build(attributes)
    end
  end
  
end
