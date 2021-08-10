class EventMailer < ApplicationMailer
  default from: 'besumero628@gmail.com', subject: "Bookers2 Event Message"
  def event_mail(owner,user,message)
    @owner = owner
    @user=user
    @message=message
    mail to: user.email
  end
end
