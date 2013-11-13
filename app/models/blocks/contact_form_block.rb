class ContactFormBlock < Block

  def submit_message message_hsh
    site = self.page.site
    message = site.owner.messages.create(read: true)
    UserMailer.contact_us(site, message).deliver
  end
end
