class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_comment
    @user = params[:user]
    @body = params[:body]
    @greeting = "Da nagel mich doch einer ans Kreuz ."

    mail to: "to@example.org"
  end
end
