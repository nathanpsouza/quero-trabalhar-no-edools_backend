# == Schema Information
#
# Table name: courses
#
#  id                    :integer          not null, primary key
#  title                 :string           not null
#  school_id             :integer          not null
#  description           :text
#  content               :text
#  duration              :string
#  price                 :decimal(8, 2)    not null
#  total_active_students :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  slug                  :string
#
# Indexes
#
#  index_courses_on_school_id  (school_id)
#  index_courses_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_adf7d91583  (school_id => schools.id)
#

class Course < ActiveRecord::Base
  belongs_to :school

  validates :title, :school, :price, presence: true
  validates :title, length: { in: 3..65 }
  validates :price, numericality: true

  has_many :enrollments, :dependent => :delete_all
  has_many :students, through: :enrollments

  searchable do
    text :title, :description, :content
  end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
