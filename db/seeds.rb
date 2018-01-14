# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning data base weddings"
Wedding.destroy_all

puts "Cleaning data base users"
User.destroy_all


puts "Création du user polo@odile - azerty"


new_user_polo = User.create({
    first_name: "Paul",
    last_name: "de Bodi",
    email: "polo@odile",
    password: "azerty",
    password_confirmation: "azerty",
    avatar_url: "https://avatars3.githubusercontent.com/u/32060402?s=460&v=4"
    })


puts "id polo : #{new_user_polo.id}"

puts "Création du user famille@testeur - azerty"

new_user_testeur = User.create({
    first_name: "Famille",
    last_name: "Testeur",
    email: "famille@testeur",
    password: "azerty",
    password_confirmation: "azerty",
    avatar_url: "https://t3.ftcdn.net/jpg/00/65/63/24/500_F_65632409_bzggYSmL28PdjZkuAVveONRGUnOsQNjr.jpg"
    })

new_user_email_testeur = User.create({
    first_name: "Polo",
    last_name: "de Bodi",
    email: "polo2bodi@gmail.com",
    password: "azerty",
    password_confirmation: "azerty",
    avatar_url: "http://blogs.lexpress.fr/styles/froggista/files/2013/07/facteur.jpg"
  })

puts "id testeurs : #{new_user_testeur.id}"

puts "Création du mariage religieux"



wedding1_polo = Wedding.create({
  title: "Mariage religieux à Pontigny",
  description: "Mariage collaboratif en Bourgogne, au milieu des vigne de Chablis. Venez passer avec nous les 3 jours du week-end de la Pentecôte. Venez vous associer à la Joie de notre engagement. On compte sur vous!",
  capacity: 51,
  user_id: new_user_polo.id,
  date: Date.new(2018, 5, 19),
  deadline: Date.new(2018, 3, 4),
  location: "Abbaye de Pontigny",
  photo_url: "https://www.le-pigeonnier-colbert.fr/wp-content/uploads/Abbaye-de-Pontigny-1040x559.jpg",
  spouse_photo_url: "http://static1.purepeople.com/articles/7/54/05/7/@/396217-richard-gere-et-cindy-crawford-950x0-3.jpg",
  spouse_first_name: "Odile",
  spouse_last_name: "Monseu"
  })

puts "Création d'1 invitation"

registry_testeurs = Registry.create({
  user_id: new_user_testeur.id,
  wedding_id: wedding1_polo.id,
  email: "famille@testeur",
  group_name: "Testeurs",
  address: "Rue des testeurs",
  zipcode: "69000",
  city: "Lyon"
  })

puts "id registry : #{registry_testeurs.id}"

puts "Creation des 5 guests adultes & 1 adulte absent & 1 enfant "

5.times do |i|
  Guest.create!({
    registry_id: registry_testeurs.id,
    name: "adulte #{i+1}",
    child: false,
    presence: nil
    })
  puts "id adulte #{i+1} : #{Guest.last.id}"
end


Guest.create({
    registry_id: registry_testeurs.id,
    name: "adulte absent",
    child: false,
    presence: nil
    })

puts "id adulte absent : #{Guest.last.id} "

Guest.create({
  registry_id: registry_testeurs.id,
  name: "l'enfant",
  child: true,
  presence: nil
  })

puts "id enfant : #{Guest.last.id} "


# wedding2_polo = Wedding.create({
#   title: "Mariage civil à Villeurbanne",
#   description: "Mariage civil, en plus petit comité : les Lyonnais, les temoins, la famille ... à la mairie de Villeurbanne. Puis soirée dans un coin de Lyon ou environs  ",
#   capacity: 33,
#   user_id: new_user_polo.id,
#   date: Date.new(2017,1,27),
#   location: "Villeurbanne",
#   photo_url: "http://ekladata.com/iFXMrulEPn1hJsuM-eAZtYl9Mzk.jpg",
#   spouse_photo_url: "https://avatars1.githubusercontent.com/u/32060402?s=400&u=33d0f8f8d6ac9979437727646e169c3173784a42&v=4",
#   spouse_first_name: "Odile",
#   spouse_last_name: "Monseu"
#   })


# wedding5_aurel = Wedding.create({
#   title: "Trinquons !",
#   description: "Parce que la vie, c'est la joie.",
#   capacity: 132,
#   user_id: new_user_aurel.id,
#   date: Date.new(2018,12,31),
#   location: "Valence, France",
#   photo_url: "https://www.theknot.com/assets/topic_pages/wedding-vows-ceremony-de390170d87b481e073afef3e03a2c7b4a5d7e0b1de1036a40816f80fa85a6cd.jpg",
#   spouse_photo_url: "https://avatars0.githubusercontent.com/u/32846131?s=400&v=4",
#   spouse_first_name: "Sylvain",
#   spouse_last_name: "Chêne"
#   })



# puts "Création de 6 messages"

# Message.create!(
#   sender: new_user_polo,
#   receiver: new_user_aurel,
#   title: 'I want to come',
#   content: 'Hi Aurel, could I participate to your wedding?'
# )

# Message.create!(
#   sender: new_user_aurel,
#   receiver: new_user_polo,
#   title: 'RE: I want to come',
#   content: 'Hi Polo, of course ! You are welcome',
# )

# Message.create!(
#   sender: new_user_polo,
#   receiver: new_user_aurel,
#   title: 'RE: I want to come',
#   content: 'Thank you so much :) '
# )

# Message.create!(
#   sender: new_user_polo,
#   receiver: new_user_horti,
#   title: 'I want to come',
#   content: 'Hi Aurel, could I participate to your wedding?'
# )

# Message.create!(
#   sender: new_user_horti,
#   receiver: new_user_polo,
#   title: 'RE: I want to come',
#   content: 'Hi Polo, of course ! You are welcome',
# )

# Message.create!(
#   sender: new_user_polo,
#   receiver: new_user_horti,
#   title: 'RE: I want to come',
#   content: 'Thank you so much :) '
# )

# Message.create!(
#   sender: new_user_aurel,
#   receiver: new_user_horti,
#   title: 'Wedding together?',
#   content: 'Hello, can I come?'
# )

# Message.create!(
#   sender: new_user_horti,
#   receiver: new_user_aurel,
#   title: 'RE: Wedding together?',
#   content: 'Yes!',
# )

puts "seed done !"

