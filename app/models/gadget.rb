class Gadget < ActiveRecord::Base
  belongs_to :user
  has_many :images, class_name: 'Image', dependent: :destroy
  validates :name, presence: true, uniqueness: true

  def cover_url
    if images.present?
      images.first.source.cover.url
    end
  end

end