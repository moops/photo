# comment model
class Comment < ActiveRecord::Base
  belongs_to :photo
end
