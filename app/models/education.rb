class Education < ApplicationRecord
  belongs_to :resume

  has_one_attached :logo

  validates :diploma_name, presence: true
  validates :institution_name, presence: true
  validates :location, presence: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  # validates :description, presence: true

  # validates :logo, presence: true

  serialize :description, JSON

  def end_date_after_start_date
    return unless end_date < start_date

    errors.add(:end_date, "La date de fin doit être après la date de début")
  end
end
