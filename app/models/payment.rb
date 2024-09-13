class Payment < ApplicationRecord
    belongs_to :booking
    before_create :set_payment_id

    def set_payment_id
        self.payment_id = "#{SecureRandom.uuid}"
      end

end
