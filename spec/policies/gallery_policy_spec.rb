require 'rails_helper'

describe GalleryPolicy do

  let(:admin) { create(:user, authority: 1) }
  let(:photographer) { create(:user, authority: 2) }
  let(:user)  { create(:user, authority: 4) }
  let!(:gallery) { create(:gallery) }

  subject { described_class }

  context ".scope" do
    it 'shows all galleries to an admin' do
      galleries = subject::Scope.new(admin, Gallery).resolve
      expect(galleries.count).to eq(1)
    end

    it 'shows all public and owned galleries to a user' do
      galleries = subject::Scope.new(user, Gallery).resolve
      expect(galleries.count).to eq(1)
    end

    it 'shows all public galleries to a guest' do
      galleries = subject::Scope.new(nil, Gallery).resolve
      expect(galleries.count).to eq(1)
    end
  end

  permissions :show? do
    it "allows access to everyone" do
      expect(subject).to permit(user, gallery)
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
      expect(subject).not_to permit(nil, gallery)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, gallery)
    end
  end

  permissions :destroy? do
    it "denies access to a guest" do
      expect(subject).not_to permit(nil, gallery)
    end
    it "allows access to an admin" do
      expect(subject).to permit(admin, gallery)
    end
  end
end

