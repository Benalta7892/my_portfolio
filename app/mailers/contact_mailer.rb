class ContactMailer < ApplicationMailer
  def contact_message(contact)
    @contact = contact
    mail(
      to: "benoit.alexandre78@gmail.com",
      from: %("#{@contact.first_name} #{@contact.last_name}" <ton-email@gmail.com>), # Affiche le nom du visiteur
      reply_to: @contact.email, # L'email du visiteur pour que tu puisses lui répondre directement
      subject: @contact.subject
    )
  end
end
