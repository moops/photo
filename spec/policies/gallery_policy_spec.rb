require 'rails_helper'

describe GalleryPolicy do

  let(:admin) { create(:user, authority: 1) }
  let(:user)  { create(:user) }
  let(:another_user)  { create(:user) }
  let!(:public_gallery) { create(:gallery) } # public, belongs to someone else
  let!(:user_gallery) { create(:gallery, user: user) } # public, belongs to user
  let!(:unowned_gallery) { create(:gallery, user: nil) } # public, belongs to nobody
  let!(:user_private_gallery) { create(:private_gallery, user: user) } # private, belongs to user
  let!(:another_user_private_gallery) { create(:private_gallery, user: another_user) } # private, belongs to another_user

  subject { described_class }

  context ".scope" do
    it 'shows all galleries to an admin' do
      galleries = subject::Scope.new(admin, Gallery).resolve
      expect(galleries.count).to eq(5)
    end

    it 'shows all public and owned galleries to a user' do
      galleries = subject::Scope.new(user, Gallery).resolve
      expect(galleries.count).to eq(4)
      expect(galleries).to include(user_private_gallery)
      expect(galleries).not_to include(another_user_private_gallery)
    end

    it 'shows all public galleries to a guest' do
      galleries = subject::Scope.new(nil, Gallery).resolve
      expect(galleries.count).to eq(3)
      expect(galleries).not_to include(user_private_gallery)
      expect(galleries).not_to include(another_user_private_gallery)
    end
  end

  permissions :show? do
    it "allows access to an owner" do
      expect(subject).to permit(user, user_gallery)
    end
    it "denies access to someone else\'s private gallery" do
      expect(subject).not_to permit(user, another_user_private_gallery)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, another_user_private_gallery)
    end
  end

  permissions :create? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, Gallery)
    end
    it "allows access to a user" do
      expect(subject).to permit(user, Gallery)
    end
  end

  permissions :update? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, public_gallery)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, user_private_gallery)
    end
  end

  permissions :destroy? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, public_gallery)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, user_private_gallery)
    end
  end
end

