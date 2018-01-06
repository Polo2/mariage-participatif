require 'json'

class Task < ApplicationRecord

  belongs_to :wedding
  # has_many :elements, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :services, dependent: :destroy

  # after_create :create_default_services

  private

  # def create_default_services


  #   file = File.read("#{Rails.root}/lib/tasks_details/details.json")
  #   defaults_services = JSON.parse(file)

  #   defaults_services[name].each do |text|
  #     Service.create(task: self, name: text)
  # end

  # end
end
