class Client < ApplicationRecord

 validates :email, presence: true, uniqueness: true,
 format: { with: URI::MailTo::EMAIL_REGEXP }
 validates :name, presence: true
 validates :cpf, presence: true, uniqueness: true

  def identification
    "#{cpf} - #{name}"
  end
end
