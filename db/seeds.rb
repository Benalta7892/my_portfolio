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
    title: "Portfolio",
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
  }
]

projects.each do |project|
  project = user.projects.create!(
    title: project[:title],
    description: project[:description],
    technologies: project[:technologies],
    link: project[:link],
    dev_count: project[:dev_count]
  )
end

puts "Projects created!"
