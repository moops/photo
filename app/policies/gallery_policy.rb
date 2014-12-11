class GalleryPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user
        user.admin? ? scope.all : scope.where(user_id: user.id)
      else
        Gallery.none
      end
    end
  end

  def show?
    # must be enrolled in course to see lesson details
    !record.private_key.nil?
  end

  def create?
    # must be logged in
    user
  end

  def update?
    # must be admin or own the gallery
    user.admin? || user.id == record.user.id if user
  end

  def destroy?
    # must be admin or own the gallery
    user.admin? || user.id == record.user.id if user
  end

end
