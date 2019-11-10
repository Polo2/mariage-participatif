require 'json'

puts "D'abord, vider la base de données existante"
Wedding.destroy_all
User.destroy_all

puts "Création de notre user polodile.mdb@gmail.com - azertyuiop"

new_user_us = User.create!(
  first_name: "Paul",
  last_name: "M2B",
  email: "polodile.mdb@gmail.com",
  password: "azertyuiop",
  password_confirmation: "azertyuiop",
)

user2 = User.create!(
  first_name: "User2",
  last_name: "Couple",
  email: "polo2bodi+1@gmail.com",
  password: "00000000",
  password_confirmation: "00000000",
)

user3 = User.create!(
  first_name: "User3",
  last_name: "Famille",
  email: "polo2bodi+2@gmail.com",
  password: "00000000",
  password_confirmation: "00000000",
)

puts "Création du mariage"

wedding = Wedding.create!(
  title: "Mariage Odile & Paul",
  description: "3 jours, 2 folies, 1 état d'esprit : le partage !",
  capacity: 300,
  user_id: new_user_us.id,
  date: Date.new(2020, 5, 19),
  deadline: Date.new(2020, 3, 4),
  location: "Abbaye de Pontigny",
  spouse_first_name: "Odile",
  spouse_last_name: "M2B",
)

puts "creation de 2 taches, 2 services chacune"

["Cuisine", "Vaisselle"].each do |task_title|
  task = Task.create!(
    name: task_title,
    wedding: wedding,
    statut: false,
  )
  2.times do |i|
    Service.create!(
      description: "#{task_title} service #{i + 1}",
      capacity: i + 1,
      task: task,
      location: "ici",
      start_at: Time.new(2020, 7, 1, 10 + i),
      stop_at: Time.new(2020, 7, 1, 11 + i)
    )
  end
end

puts "Création de 2 invitations"

registry_couple = Registry.create!(
  user_id: user2.id,
  wedding_id: wedding.id,
  email: user2.email,
  group_name: "2 Testeurs",
  address: "Rue du couple",
  total: 2,
  zipcode: "69000",
  city: "Lyon",
  score_registry: 0,
)

registry_family = Registry.create!(
  user_id: user3.id,
  wedding_id: wedding.id,
  email: user3.email,
  group_name: "3 Testeurs",
  total: 4,
  address: "Rue de la famille",
  zipcode: "69000",
  city: "Lyon",
  score_registry: 0,
)

puts "Creation des 2 guests adultes pour invitation 2, inscrit à la cuisine"
puts "Creation des 2 guests adultes & 1 adulte absent & 1 enfant pour invitation 3, sans invitation "

2.times do |i|
  Guest.create!(
    registry_id: registry_couple.id,
    name: "adulte A #{i + 1}",
    child: false,
    presence:true,
    service: Service.find_by!(description: "Cuisine service 2")
  )
end

2.times do |i|
  Guest.create!(
    registry_id: registry_family.id,
    name: "adulte A #{i + 1}",
    child: false,
    presence:true
  )
end

Guest.create!(
  registry_id: registry_family.id,
  name: "adulte absent",
  child: false,
  presence: false
)

Guest.create!(
  registry_id: registry_family.id,
  name: "l'enfant",
  child: true,
  presence: true
)

Discussion.create!(
  wedding: wedding,
  name: "Discussion"
)

puts "Graines plantées ! Bon Dev Polo ;)"
