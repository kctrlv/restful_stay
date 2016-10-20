class ConfirmationSender
  def self.send_confirmation_to(user)
    verification_code = TwilioService.code_generator
    user.update(verification_code: verification_code)
  end
end
