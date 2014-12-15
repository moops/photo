class GalleryPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user
        if user.admin?
          scope.all
        else
          scope.where('user_id = ? or private_key is null', user.id)
        end
      else
        scope.where(private_key: nil)
      end
    end
  end

  def show?
    # admin or public gallery or gallery owner
    user.admin? || record.private_key.nil? || record.user.id == user.id
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