class PaymentMailer < ApplicationMailer
  default from: 'no-reply@apayi.in'

  def email_checkout_url(user_email, url)
    @checkout_url = url
    mail(from: 'no-reply@apayi.in', to: user_email, subject: "Payment url")
  end

end
