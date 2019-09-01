class Question < ApplicationRecord
  validates :name, presence: true
  validates :email,
    presence: true,
    format: {
      with: /\A[^@\s]+@[^@\s]+\z/,
      message: "une vraie adresse email pour une vraie réponse, svp"
    }
  validates :message,
    presence: true,
    length: { minimum: 33, too_short: "33 charactères minimum" }

  after_create :send_question

  private

  def send_question
    QuestionMailer.new_question(self).deliver_now
  end
end
