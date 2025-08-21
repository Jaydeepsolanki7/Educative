class UserMailer < ApplicationMailer
  def welcome_email
    mail(
      to: params[:user].email,
      body: params[:email_body],
      content_type: "text/html",
      subject: "Already rendered!"
    )
  end
end
