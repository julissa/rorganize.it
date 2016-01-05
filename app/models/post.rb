# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  picture      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  person_id    :integer
#  draft        :boolean          default(FALSE), not null
#  slug         :string(255)
#  published_at :datetime
#

class Post < ActiveRecord::Base

  scope :published, -> { where(draft: false).order(published_at: :desc)}
  scope :draft, -> { where(draft: true).order(created_at: :desc) }

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :person

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  def set_published_at!
    update_attribute(:published_at, Time.now.utc)
  end

  def older_post
    Post.published.where("published_at < ?", published_at).order(published_at: :desc).first
  end

  def newer_post
    Post.published.where("published_at > ?", published_at).order(published_at: :asc).first
  end
end
