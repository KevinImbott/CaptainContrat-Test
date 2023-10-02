# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  champion = Champion.create!(name: Faker::Name.first_name)
  file = URI.open(Faker::Avatar.image)
  champion.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
end

5.times do
  champion_id = Champion.all.sample.id
  opponent_id = Champion.all.sample.id

  until champion_id != opponent_id
    champion_id = Champion.all.sample.id
  end

  Battle.create!(champion_id: champion_id, opponent_id: opponent_id)
end