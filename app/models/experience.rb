class Experience < ApplicationRecord
  belongs_to :resume

  validates :job_title, presence: true
  validates :company_name, presence: true
  validates :location, presence: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  validates :missions, presence: true

  validates :logo, presence: true

  def end_date_after_start_date
    return unless end_date < start_date

    errors.add(:end_date, "La date de fin doit être après la date de début")
  end
end
