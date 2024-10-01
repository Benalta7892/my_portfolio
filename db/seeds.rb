require "open-uri"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear the database
puts "Clearing the database..."
User.destroy_all
Contact.destroy_all
Project.destroy_all


# Create a user
puts "Creating a user..."
user = User.create!(
  last_name: ENV["LAST_NAME_ADMIN"],
  first_name: ENV["FIRST_NAME_ADMIN"],
  email: ENV["EMAIL_ADMIN"],
  password: ENV["PASSWORD_ADMIN"],
  bio: ENV["BIO_ADMIN"],
  links: ENV["LINKS_ADMIN"],
  admin: ENV["ADMIN_USER"] == "true"
)

puts "Attaching an avatar to the user..."
unless user.avatar.attached?
  user.avatar.attach(io: URI.open(ENV["AVATAR_ADMIN"]), filename: "avatar.jpg")
end

puts "User created!"

# Create projects
puts "Creating projects..."

projects = [
  {
    title: "Zero to Heroes",
    description: "This is my portfolio. I built it with Ruby on Rails.",
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/zerotoheros_ayxbcc.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku",
    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "Pokéswype",
    description: "This is a Pokémon game. I built it with JavaScript.",
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799295/development/pokeswype_copie_ymvvv7.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799314/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.23.41_ywfz5a.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799319/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.11_alwxam.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799325/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.41_pbv64u.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799330/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.26.55_d3ukct.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799334/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.05_m2k2hw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799346/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.52_rqoav1.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799348/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.29.28_zmhylb.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799354/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.30_wnnsgq.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799358/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.40_hfuroi.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799362/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.31.04_thidt0.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku, QRcode, PokeAPI, messenger",
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  },
  {
    title: "Zero to Heroes",
    description: "This is my portfolio. I built it with Ruby on Rails.",
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/zerotoheros_ayxbcc.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku",
    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "Pokéswype",
    description: "This is a Pokémon game. I built it with JavaScript.",
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799295/development/pokeswype_copie_ymvvv7.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799314/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.23.41_ywfz5a.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799319/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.11_alwxam.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799325/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.41_pbv64u.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799330/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.26.55_d3ukct.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799334/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.05_m2k2hw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799346/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.52_rqoav1.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799348/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.29.28_zmhylb.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799354/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.30_wnnsgq.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799358/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.40_hfuroi.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799362/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.31.04_thidt0.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku, QRcode, PokeAPI, messenger",
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  }

]

projects.each do |project_data|
  project = user.projects.create!(
    title: project_data[:title],
    description: project_data[:description],
    technologies: project_data[:technologies],
    link: project_data[:link],
    dev_count: project_data[:dev_count]
  )

  if project_data[:pictures]
    project_data[:pictures].each_with_index do |picture_url, index|
      project.pictures.attach(io: URI.open(picture_url), filename: "picture_#{index}.jpg")
    end
  end
end

puts "Projects created!"
