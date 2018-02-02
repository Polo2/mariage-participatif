class QuestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.new_question.subject
  #
  def new_question(question)
    @question = question
    mail(from: "paul@mariage-participatif.fr", to: "paul@mariage-participatif.fr",  subject: "mariage-participatif.fr : Nouveau message de #{@question.name}")
  end
end

