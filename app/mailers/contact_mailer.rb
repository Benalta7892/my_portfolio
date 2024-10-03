class ContactMailer < ApplicationMailer
  default to: ENV.fetch('EMAIL_ADMIN', nil)

  def contact_message(contact)
    @contact = contact
    mail(
      from: @contact.email,
      reply_to: @contact.email,
      subject: @contact.subject
    )
  end
end
