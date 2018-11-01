class InviteMailer < ActionMailer::Base
  default from: 'yujiriwc@gmail.com'

  def invitation_email(email, invite)
    @url = 'https://kodo-test-em.herokuapp.com/signup/' + invite
    mail(to: email, subject: 'Invite for TestTask application')
  end
end
