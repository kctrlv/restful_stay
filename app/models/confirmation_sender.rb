class ConfirmationSender < ApplicationRecord
  def self.send_confirmation_to(user)
    verification_code = TwilioService.code_generator
    user.update_attributes(verification_code: verification_code)
  end
end
