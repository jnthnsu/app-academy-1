class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: {in: ['PENDING', 'APPROVED', 'DENIED']}
  validate :start_after_end
  validate :overlapping_approved_requests

  belongs_to :cat

  def start_after_end
    unless self.start_date < self.end_date
      self.errors[:end_date] << "before start date."
    end
  end

  def overlapping_requests
    cat.cat_rental_requests.where("? <= end_date AND ? >= start_date", start_date, end_date)
  end

  def overlapping_approved_requests
    if overlapping_requests.exists?(status: 'APPROVED')
      self.errors[:cat] << "is booked."
    end
  end

  def approve!
    CatRentalRequest.transaction do
      update(status: 'APPROVED')

      overlapping_requests.where(status: 'PENDING').each do |request|
        request.deny!
      end
    end
  end

  def deny!
    update(status: 'DENIED')
  end

end
