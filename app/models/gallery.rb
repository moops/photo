class Gallery < ActiveRecord::Base

  has_many :photos

  def self.recent_galleries
    Gallery.find(:all,
                 :conditions => ['private_key is null'],
                 :order => 'gallery_on desc',
                 :limit => 6)
  end
               
  def find_public
    findSql = 'private_key is null and name like ?'
    find_conditions = [findSql,"%#{name}%"]
    if gallery_on
      findSql += ' and gallery_on = ?'
      find_conditions[0] = findSql
      find_conditions << gallery_on
    end
    Gallery.find(:all, 
                 :conditions => find_conditions, 
                 :order => 'name',
                 :page => {:size => 10})
  end

  def find_private
    Gallery.find(:first, :conditions => ['private_key = ?',private_key])
  end

  def photo_count
    photos.size
  end
  
end
