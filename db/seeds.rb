require "open-uri"
require 'cloudinary'
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

ProjectTechnology.destroy_all
Experience.destroy_all
Education.destroy_all
Project.destroy_all
Resume.destroy_all
TechnologyItem.destroy_all
Contact.destroy_all
User.destroy_all

puts "Database cleared!"


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
puts user.avatar.attached? ? "Avatar attached successfully!" : "Failed to attach avatar."

puts "User created!"


puts "Creating TechnologyItems"

frontend_technologies = [
  { name: "Figma", link: "https://www.figma.com/fr-fr/", local_logo: "logos/figma.png", alt: "Figma logo", order_position: 1 },
  { name: "HTML5", link: "https://developer.mozilla.org/fr/docs/Web/HTML", local_logo: "logos/html5.png", alt: "HTML5 logo", order_position: 2 },
  { name: "CSS3", link: "https://developer.mozilla.org/fr/docs/Web/CSS", local_logo: "logos/css3.png", alt: "CSS3 logo", order_position: 3 },
  { name: "JavaScript", link: "https://developer.mozilla.org/fr/docs/Web/JavaScript", local_logo: "logos/js.png", alt: "JavaScript logo", order_position: 4 },
  { name: "Stimulus", link: "https://stimulus.hotwired.dev/", local_logo: "logos/stimulus.png", alt: "Stimulus logo", order_position: 5 },
  { name: "Sass", link: "https://sass-lang.com/", local_logo: "logos/sass.png", alt: "Sass logo", order_position: 6 },
]

backend_technologies = [
  { name: "Ruby", link: "https://www.ruby-lang.org/fr/", local_logo: "logos/ruby.png", alt: "Ruby logo", order_position: 1 },
  { name: "Rails", link: "https://rubyonrails.org/", local_logo: "logos/rails.png", alt: "Rails logo", order_position: 2 },
  { name: "PHP", link: "https://www.php.net/", local_logo: "logos/php.png", alt: "PHP logo", order_position: 3 },
  { name: "Devise", link: "https://github.com/heartcombo/devise", local_logo: "logos/devise.png", alt: "Devise logo", order_position: 4 },
  { name: "Cloudinary", link: "https://cloudinary.com/", local_logo: "logos/cloudinary.png", alt: "Cloudinary logo", order_position: 5 },
  { name: "Postman", link: "https://www.postman.com/", local_logo: "logos/postman.png", alt: "Postman logo", order_position: 6 },
  { name: "PostgreSQL", link: "https://www.postgresql.org/", local_logo: "logos/postgresql.png", alt: "PostgreSQL logo", order_position: 7 },
  { name: "Heroku", link: "https://www.heroku.com/", local_logo: "logos/heroku.png", alt: "Heroku logo", order_position: 8 },
]

tools = [
  { name: "VSCode", link: "https://code.visualstudio.com/", local_logo: "logos/vscode.png", alt: "VSCode logo", order_position: 1 },
  { name: "Git", link: "https://git-scm.com/", local_logo: "logos/git.png", alt: "Git logo", order_position: 2 },
  { name: "GitHub", link: "https://github.com/", local_logo: "logos/github1.png", alt: "GitHub logo", order_position: 3 },
  { name: "Slack", link: "https://slack.com/intl/fr-fr/", local_logo: "logos/slack.png", alt: "Slack logo", order_position: 4 },
  { name: "Trello", link: "https://trello.com/fr", local_logo: "logos/trello.png", alt: "Trello logo", order_position: 5 },
]

def create_technology_items(technologies, category)
  technologies.each do |tech|
    technology = TechnologyItem.create!(
      name: tech[:name],
      link: tech[:link],
      category: category,
      order_position: tech[:order_position],
      local_logo: tech[:local_logo],
    )

    # if tech[:logo].present? && !technology.logo.attached?
    #   logo_url = "https://res.cloudinary.com/tl0y1cue/image/upload/#{tech[:version]}/#{tech[:logo]}"
    #   file = URI.open(logo_url)
    #   technology.logo.attach(io: file, filename: tech[:logo], content_type: "image/png")
    # end
  end
end

create_technology_items(frontend_technologies, 'frontend')
create_technology_items(backend_technologies, 'backend')
create_technology_items(tools, 'tools')

puts "TechnologyItems created!"


puts "Creating projects..."

projects = [
  {
    title: "Zero to Heroes",
    subtitle: "Application web de location.",
    description: "Une plateforme de location pour des événements spéciaux, inspirée du modèle d’Airbnb.
      Avec une interface intuitive et une gestion fluide des réservations,
      elle offre une expérience utilisateur optimale.
      Le projet repose sur un concept ludique de super-héros,
      permettant d’explorer les fonctionnalités clés d’un service de réservation en ligne.",
    features: [
      "Un espace personnel sécurisé.",
      "La gestion des réservations.",
      "Une recherche basée sur la géolocalisation.",
      "La réservation à la journée ou pour plusieurs jours."
    ],
    pictures: [
      "projects/zero_to_heroes/zerotoheroes1.png",
      "projects/zero_to_heroes/zerotoheroes2.png",
      "projects/zero_to_heroes/zerotoheroes3.png",
      "projects/zero_to_heroes/zerotoheroes4.png"
    ],
    background_image: "projects/zero_to_heroes/zerotoheroesBG.jpg",
    frontend_technologies: TechnologyItem.where(name: ["HTML5", "CSS3", "JavaScript", "Stimulus", "Sass", "Figma"]),
    backend_technologies: TechnologyItem.where(name: ["Rails", "Devise", "Cloudinary", "Postman", "PostgreSQL", "Heroku"]),
    tools: TechnologyItem.where(name: ["VSCode", "Git", "GitHub", "Slack", "Trello"]),

    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "PokéSwype",
    subtitle: "Application web de collection.",
    description: "PokéSwype, c’est le Tinder des cartes Pokémon :
      une application web mobile qui connecte les passionnés pour échanger leurs cartes et gérer leurs collections.
      Ce projet a été l’occasion de travailler sur des interfaces intuitives, la gestion de bases de données
      et des fonctionnalités de réseau social rendant les échanges plus accessibles.",
    features: [
      "Un espace personnel sécurisé.",
      "La gestion des échanges de cartes.",
      "Une recherche avec Swype, basée sur la géolocalisation.",
      "Une messagerie instantanée.",
      "La validation des échanges par QR Code.",
      "Des notifications en temps réel.",
      "Un système de notation pour renforcer la confiance."
    ],
    pictures: [
      "projects/pokeswype/pokeswype1.png",
      "projects/pokeswype/pokeswype2.png",
      "projects/pokeswype/pokeswype3.png",
      "projects/pokeswype/pokeswype4.png",
      "projects/pokeswype/pokeswype5.png",
      "projects/pokeswype/pokeswype6.png",
      "projects/pokeswype/pokeswype7.png",
      "projects/pokeswype/pokeswype8.png",
      "projects/pokeswype/pokeswype9.png",
      "projects/pokeswype/pokeswype10.png",
    ],
    background_image: "projects/pokeswype/pokeswypeBG.jpg",
    frontend_technologies: TechnologyItem.where(name: ["HTML5", "CSS3", "JavaScript", "Sass", "Figma"]),
    backend_technologies: TechnologyItem.where(name: ["Rails", "Devise", "Cloudinary", "Postman", "PostgreSQL", "Heroku"]),
    tools: TechnologyItem.where(name: ["VSCode", "Git", "GitHub", "Slack", "Trello"]),
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  },
]

projects.each do |project_data|
  project = user.projects.create!(
    title: project_data[:title],
    subtitle: project_data[:subtitle],
    description: project_data[:description],
    features: project_data[:features],
    link: project_data[:link],
    dev_count: project_data[:dev_count],
    local_pictures: project_data[:pictures],
    local_background_image: project_data[:background_image]
  )

  # if project_data[:pictures] && !project.pictures.attached?
  #   project_data[:pictures].each_with_index do |picture_url, index|
  #     project.pictures.attach(io: URI.open(picture_url), filename: "picture_#{index}.jpg")
  #   end
  # end

  # if project_data[:background_image] && !project.background_image.attached?
  #   project.background_image.attach(io: URI.open(project_data[:background_image]), filename: "background_image.jpg")
  # end

  project.frontend_technologies << project_data[:frontend_technologies].to_a

  project.backend_technologies << project_data[:backend_technologies].to_a

  project.tools << project_data[:tools].to_a
end

puts "Projects created!"


puts "Creating a resume..."

resume = user.create_resume!(
  title: "Mon CV",
  description: [
    "Du commerce à la tech, je m’épanouis dans la création d’applications web
    alliant simplicité, esthétique et performance.",

    "Transformer des idées en solutions digitales me conduit à faire la lumière sur de nouvelles
    technologies – un terrain de jeu et d’apprentissage qui me captive depuis longtemps,
    stimulant ma curiosité et nourrissant mon desir d'aller toujours plus loin."
  ]
)

unless resume.picture.attached?
  resume.picture.attach(io: URI.open("https://res.cloudinary.com/tl0y1cue/image/upload/v1787342994/my_portfolio/development/AlexandreTachdjianBenoitCVOP.png"), filename: "AlexandreTachdjianBenoitCVOP.png")
end

unless resume.pdf.attached?
  resume.pdf.attach(io: URI.open("https://res.cloudinary.com/tl0y1cue/image/upload/v1787345206/my_portfolio/development/AlexandreTachdjianBenoitCVO.pdf"), filename: "AlexandreTachdjianBenoitCVO.pdf")
end

puts "Resume created: #{resume.title}"


puts "Creating educations..."

educations = [
  {
    diploma_name: "Web Development Bootcamp",
    institution_name: "Le Wagon",
    location: "Paris, France",
    start_date: Date.new(2023, 10),
    end_date: Date.new(2024, 4),
    description: [
      "Bootcamp intensif de codage (6 mois).",
      "Langages et technologies : Ruby on Rails, HTML, CSS, Bootstrap, JavaScript, SQL, Git, GitHub, Heroku.",
      "Conceptions Logicielles : Architecture MVC, conception et gestion de bases de données.",
      "Projets Phares : Clone d'Airbnb et PokéSwype",
      "Développement en équipe depuis la conception jusqu'au déploiement."
    ],
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306056/pngwing.com_rflqgf.png",
    order_position: 1
  },
  {
    diploma_name: "Bachelor Gestion et Transaction Immobilière",
    institution_name: "Institut du Management des Services Immobiliers (IMSI) - Groupe IGS",
    location: "Paris, France",
    start_date: Date.new(2016, 2),
    end_date: Date.new(2016, 10),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306069/logo_zhk3sf.webp",
    order_position: 2
  },
  {
    diploma_name: "Bachelor Gestionnaire d'Unité Commercial",
    institution_name: "Novancia Business School",
    location: "Paris, France",
    start_date: Date.new(2013, 2),
    end_date: Date.new(2014, 11),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306115/Novancia_Business_School_logo_ujzhry.png",
    order_position: 3
  },
  {
    diploma_name: "Bac Sciences et Technologies de la Gestion",
    institution_name: "Lycée René Cassin",
    location: "Arpajon, France",
    start_date: Date.new(2010, 9),
    end_date: Date.new(2011, 6),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306115/academyversailles_msrk7l.png",
    order_position: 4
  }
]

educations.each do |education_data|
  education = resume.educations.create!(
    diploma_name: education_data[:diploma_name],
    institution_name: education_data[:institution_name],
    location: education_data[:location],
    start_date: education_data[:start_date],
    end_date: education_data[:end_date],
    description: education_data[:description] || nil,
    order_position: education_data[:order_position]
    )

    # if education_data[:logo].present?
    #   education.logo.attach(io: URI.open(education_data[:logo]), filename: "logo.jpg")
    # end
end

puts "Educations created!"


puts "Creating experiences..."

experiences = [
  {
    job_title: "Conseiller vendeur",
    company_name: "Nodus Parly 2",
    location: "Le Chesnay, France",
    start_date: Date.new(2019, 5),
    end_date: Date.new(2023, 1),
    missions: [
      "Autonome dans la gestion complète de la boutique : Ouverture/fermeture, conseils/ventes,
        encaissement, stocks, merchandising, suivi du CA."
    ],
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306117/noduslogo_gihmsr.jpg",
    order_position: 1
  },
  {
    job_title: "Conseiller vendeur",
    company_name: "Zara Parly 2",
    location: "Le Chesnay, France",
    start_date: Date.new(2016, 11),
    end_date: Date.new(2023, 1),
    missions: [
      "Amélioration continue en compétences organisationnelles à travers diverses tâches :
      Réassortiments des articles, merchandising, encaissement et entretien général."
    ],
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/Zara_Logo_curxt1.png",
    order_position: 2
  },
  {
    job_title: "Chargé de gestion locative",
    company_name: "Réside Études, Les Estudines",
    location: "Levallois-Perret, France",
    start_date: Date.new(2016, 2),
    end_date: Date.new(2016, 10),
    missions: [
      "Adaptabilité renforcée dans un environnement de travail exigeants et évolutifs.",
      "Capacité de coordination, pour une gestion efficace des opérations locatives : Visites,
      états des lieux, rédaction des baux, suivi des paiements et des réparations.",
      "Compétences validées en résolution de problèmes : Réclamations locataires et services
      généraux."
    ],
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306118/resideetudes_ysx4tv.png",
    order_position: 3
  },
  {
    job_title: "Responsable chaussures et accessoires",
    company_name: "Zara Parly 2",
    location: "Le Chesnay, France",
    start_date: Date.new(2013, 1),
    end_date: Date.new(2016, 2),
    missions: [
      "Développement d'aptitudes en leadership : Assumé la responsabilité de communiquer les
      objectifs et de confier des tâches, favorisant ainsi l'esprit d'équipe.",
      "Vision commerciale consolidée : Stratégies d'optimisation des ventes et de promotions."
    ],
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/Zara_Logo_curxt1.png",
    order_position: 4
  },
  {
    job_title: "Conseiller vendeur",
    company_name: "Jules, Casa, Total",
    location: "Thiais, France",
    start_date: Date.new(2017, 9),
    end_date: Date.new(2019, 5),
    missions: [
      "Acquisition de compétences en vente clés, contribuant activement à l'atteinte des
      objectifs commerciaux."
    ],
    logo: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306117/jules_klblcd.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306116/casa_acroll.webp",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/logo_totalenergies_sim0jr.webp"
    ],
    order_position: 5
  }
]

experiences.each do |experience_data|
  experience = resume.experiences.create!(
    job_title: experience_data[:job_title],
    company_name: experience_data[:company_name],
    location: experience_data[:location],
    start_date: experience_data[:start_date],
    end_date: experience_data[:end_date],
    missions: experience_data[:missions],
    order_position: experience_data[:order_position]
  )

  # if experience_data[:logo].present?
  #   if experience_data[:logo].is_a?(Array)
  #     experience_data[:logo].each_with_index do |logo_url, index|
  #       experience.logos.attach(io: URI.open(logo_url), filename: "logo_#{index}.jpg")
  #     end
  #   elsif experience_data[:logo].is_a?(String)
  #     experience.logos.attach(io: URI.open(experience_data[:logo]), filename: "logo.jpg")
  #   end
  # end
end

puts "Experiences created!"
