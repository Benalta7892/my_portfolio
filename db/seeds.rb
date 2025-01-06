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
  { name: "Figma", link: "https://www.figma.com/fr-fr/", logo: "figma_d7mc4z.png", version: "v1727700623", alt: "Figma logo", order_position: 1 },
  { name: "HTML5", link: "https://developer.mozilla.org/fr/docs/Web/HTML", logo: "html5_kf7hmz.png", version: "v1727700623", alt: "HTML5 logo", order_position: 2 },
  { name: "CSS3", link: "https://developer.mozilla.org/fr/docs/Web/CSS", logo: "css3_q9lv1h.png", version: "v1727700623", alt: "CSS3 logo", order_position: 3 },
  { name: "JavaScript", link: "https://developer.mozilla.org/fr/docs/Web/JavaScript", logo: "js_qh6ndw.png", version: "v1727700623", alt: "JavaScript logo", order_position: 4 },
  { name: "Stimulus", link: "https://stimulus.hotwired.dev/", logo: "stimulus_byehql.png", version: "v1728895436", alt: "Stimulus logo", order_position: 5 },
  { name: "Sass", link: "https://sass-lang.com/", logo: "sass_lfse0e.png", version: "v1728894867", alt: "Sass logo", order_position: 6 },
]

backend_technologies = [
  { name: "Ruby", link: "https://www.ruby-lang.org/fr/", logo: "ruby_u4fzgi.png", version: "v1727700624", alt: "Ruby logo", order_position: 1 },
  { name: "Rails", link: "https://rubyonrails.org/", logo: "rails_w8dl1x.png", version: "v1727700624", alt: "Rails logo", order_position: 2 },
  { name: "PHP", link: "https://www.php.net/", logo: "php_ehpiwx.png", version: "v1727700623", alt: "PHP logo", order_position: 3 },
  { name: "Devise", link: "https://github.com/heartcombo/devise", logo: "devise_p8bflb.png", version: "v1728894338", alt: "Devise logo", order_position: 4 },
  { name: "Cloudinary", link: "https://cloudinary.com/", logo: "cloudinary_mrktzt.png", version: "v1728894646", alt: "Cloudinary logo", order_position: 5 },
  { name: "Postman", link: "https://www.postman.com/", logo: "postman_y3zgpe.png", version: "v1729721156", alt: "Postman logo", order_position: 6 },
  { name: "PostgreSQL", link: "https://www.postgresql.org/", logo: "postgresql_czwsff.png", version: "v1727700624", alt: "PostgreSQL logo", order_position: 7 },
  { name: "Heroku", link: "https://www.heroku.com/", logo: "heroku_vqw6qd.png", version: "v1727700623", alt: "Heroku logo", order_position: 8 },
]

tools = [
  { name: "VSCode", link: "https://code.visualstudio.com/", logo: "vscode_aio2rn.png", version: "v1729717392", alt: "VSCode logo", order_position: 1 },
  { name: "Git", link: "https://git-scm.com/", logo: "git_h8j6pt.png", version: "v1728900994", alt: "Git logo", order_position: 2 },
  { name: "GitHub", link: "https://github.com/", logo: "github_hjj2ba.png", version: "v1728900778", alt: "GitHub logo", order_position: 3 },
  { name: "Slack", link: "https://slack.com/intl/fr-fr/", logo: "slack_ft3jeu.png", version: "v1729721553", alt: "Slack logo", order_position: 4 },
  { name: "Trello", link: "https://trello.com/fr", logo: "trello_zsnis6.png", version: "v1728894156", alt: "Trello logo", order_position: 5 },
]

def create_technology_items(technologies, category)
  technologies.each do |tech|
    technology = TechnologyItem.create!(
      name: tech[:name],
      link: tech[:link],
      category: category,
      order_position: tech[:order_position]
    )

    if tech[:logo].present? && !technology.logo.attached?
      logo_url = logo_url = "https://res.cloudinary.com/djgk65kdl/image/upload/#{tech[:version]}/#{tech[:logo]}"
      file = URI.open(logo_url)
      technology.logo.attach(io: file, filename: tech[:logo], content_type: "image/png")
    end
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
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1731125857/zerotohero1_ntkhgr.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    background_image: "https://res.cloudinary.com/djgk65kdl/image/upload/v1731370314/hero1_oqudl7.jpg",
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
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799295/pokeswype_copie_ymvvv7.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799314/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.23.41_ywfz5a.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799319/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.11_alwxam.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799325/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.24.41_pbv64u.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799330/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.26.55_d3ukct.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799334/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.05_m2k2hw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799346/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.28.52_rqoav1.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799348/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.29.28_zmhylb.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799354/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.30_wnnsgq.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799358/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.30.40_hfuroi.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727799362/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_17.31.04_thidt0.png"
    ],
    background_image: "https://res.cloudinary.com/djgk65kdl/image/upload/v1731370403/poke1_jg78kt.jpg",
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
    dev_count: project_data[:dev_count]
  )

  if project_data[:pictures] && !project.pictures.attached?
    project_data[:pictures].each_with_index do |picture_url, index|
      project.pictures.attach(io: URI.open(picture_url), filename: "picture_#{index}.jpg")
    end
  end

  if project_data[:background_image] && !project.background_image.attached?
    project.background_image.attach(io: URI.open(project_data[:background_image]), filename: "background_image.jpg")
  end

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
  resume.picture.attach(io: URI.open("https://res.cloudinary.com/djgk65kdl/image/upload/v1733305726/BenoitAlexandreCVimg_mhk6jb.png"), filename: "cv.jpg")
end

unless resume.pdf.attached?
  resume.pdf.attach(io: URI.open("https://res.cloudinary.com/djgk65kdl/image/upload/v1733305455/BenoitAlexandreCV_ljpjtl.pdf"), filename: "BenoitAlexandreCV.pdf")
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

    if education_data[:logo].present?
      education.logo.attach(io: URI.open(education_data[:logo]), filename: "logo.jpg")
    end
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

  if experience_data[:logo].present?
    if experience_data[:logo].is_a?(Array)
      experience_data[:logo].each_with_index do |logo_url, index|
        experience.logos.attach(io: URI.open(logo_url), filename: "logo_#{index}.jpg")
      end
    elsif experience_data[:logo].is_a?(String)
      experience.logos.attach(io: URI.open(experience_data[:logo]), filename: "logo.jpg")
    end
  end
end

puts "Experiences created!"
