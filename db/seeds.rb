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

# Supprimer les dépendances directes d'abord
ProjectTechnology.destroy_all
Experience.destroy_all
Education.destroy_all
Project.destroy_all
Resume.destroy_all
TechnologyItem.destroy_all
Contact.destroy_all

# Supprimer l'utilisateur à la fin
User.destroy_all

puts "Database cleared!"


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


puts "Creating TechnologyItems"

frontend_technologies = [
  { name: "Figma", link: "https://www.figma.com/fr-fr/", logo: "figma_d7mc4z.png", alt: "Figma logo", order_position: 1 },
  { name: "HTML5", link: "https://developer.mozilla.org/fr/docs/Web/HTML", logo: "html5_kf7hmz.png", alt: "HTML5 logo", order_position: 2 },
  { name: "CSS3", link: "https://developer.mozilla.org/fr/docs/Web/CSS", logo: "css3_q9lv1h.png", alt: "CSS3 logo", order_position: 3 },
  { name: "JavaScript", link: "https://developer.mozilla.org/fr/docs/Web/JavaScript", logo: "js_qh6ndw.png", alt: "JavaScript logo", order_position: 4 },
  { name: "Stimulus", link: "https://stimulus.hotwired.dev/", logo: "stimulus_byehql.png", alt: "Stimulus logo", order_position: 5 },
  { name: "Sass", link: "https://sass-lang.com/", logo: "sass_lfse0e.png", alt: "Sass logo", order_position: 6 },
]

backend_technologies = [
  { name: "Ruby", link: "https://www.ruby-lang.org/fr/", logo: "ruby_u4fzgi.png", alt: "Ruby logo", order_position: 1 },
  { name: "Rails", link: "https://rubyonrails.org/", logo: "rails_w8dl1x.png", alt: "Rails logo", order_position: 2 },
  { name: "PHP", link: "https://www.php.net/", logo: "php_ehpiwx.png", alt: "PHP logo", order_position: 3 },
  { name: "Devise", link: "https://github.com/heartcombo/devise", logo: "devise_p8bflb.png", alt: "Devise logo", order_position: 4 },
  { name: "Cloudinary", link: "https://cloudinary.com/", logo: "cloudinary_mrktzt.png", alt: "Cloudinary logo", order_position: 5 },
  { name: "Postman", link: "https://www.postman.com/", logo: "postman_y3zgpe.png", alt: "Postman logo", order_position: 6 },
  { name: "PostgreSQL", link: "https://www.postgresql.org/", logo: "postgresql_czwsff.png", alt: "PostgreSQL logo", order_position: 7 },
  { name: "Heroku", link: "https://www.heroku.com/", logo: "heroku_vqw6qd.png", alt: "Heroku logo", order_position: 8 },
]

tools = [
  { name: "VSCode", link: "https://code.visualstudio.com/", logo: "vscode_aio2rn.png", alt: "VSCode logo", order_position: 1 },
  { name: "Git", link: "https://git-scm.com/", logo: "git_h8j6pt.png", alt: "Git logo", order_position: 2 },
  { name: "GitHub", link: "https://github.com/", logo: "github_hjj2ba.png", alt: "GitHub logo", order_position: 3 },
  { name: "Slack", link: "https://slack.com/intl/fr-fr/", logo: "slack_ft3jeu.png", alt: "Slack logo", order_position: 4 },
  { name: "Trello", link: "https://trello.com/fr", logo: "trello_zsnis6.png", alt: "Trello logo", order_position: 5 },
]

def create_technology_items(technologies, category)
  technologies.each do |tech|
    # Création de la technologie avec les champs 'name', 'link', et 'category'
    technology = TechnologyItem.create!(
      name: tech[:name],
      link: tech[:link],
      category: category,
      order_position: tech[:order_position]
    )

    # Attacher le logo via l'URL Cloudinary générée à partir de l'identifiant
    if tech[:logo].present?
      # Construire l'URL de l'image à partir de l'identifiant de Cloudinary
      logo_url = logo_url = "https://res.cloudinary.com/djgk65kdl/image/upload/development/#{tech[:logo]}"
      file = URI.open(logo_url)
      # Attacher le fichier à la technologie en utilisant Active Storage
      technology.logo.attach(io: file, filename: tech[:logo], content_type: "image/png")
    end
  end
end

create_technology_items(frontend_technologies, 'frontend')
create_technology_items(backend_technologies, 'backend')
create_technology_items(tools, 'tools')

puts "TechnologyItems created!"


# Create projects
puts "Creating projects..."

projects = [
  {
    title: "Zero to Heroes1",
    subtitle: "Application web de location.",
    description: "Imaginez un service unique qui permet aux utilisateurs de louer des super-héros pour des événements spéciaux. Une interface intuitive combinée à une gestion fluide des réservations, conçue pour offrir une expérience inoubliable.",
    features: [
      "Espace personnel sécurisé.",
      "Gestion des réservations.",
      "Recherche basée sur la géolocalisation.",
      "Réservation à la journée ou pour plusieurs jours."
    ],
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1731125857/development/zerotohero1_ntkhgr.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    # Référence aux objets TechnologyItem par catégorie
    frontend_technologies: TechnologyItem.where(name: ["HTML5", "CSS3", "JavaScript", "Stimulus", "Sass", "Figma"]),
    backend_technologies: TechnologyItem.where(name: ["Rails", "Devise", "Cloudinary", "Postman", "PostgreSQL", "Heroku"]),
    tools: TechnologyItem.where(name: ["VSCode", "Git", "GitHub", "Slack", "Trello"]),

    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "PokéSwype1",
    subtitle: "Application web de collection.",
    description: "PokéSwype est une application web qui vous connecte à d'autres dresseurs pour échanger des cartes Pokémon et enrichir votre collection. Profitez d'un réseau social dynamique où vous pouvez discuter et négocier vos échanges en un simple glissement.",
    features: [
      "Espace personnel sécurisé.",
      "Gestion des échanges de cartes.",
      "Recherche avec Swype, basée sur la géolocalisation.",
      "Messagerie instantanée",
      "Validation des échange par QR Code",
      "Notifications en temps réel",
      "Système de notation pour renforcer la confiance."
    ],
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
    # Référence aux objets TechnologyItem par catégorie
    frontend_technologies: TechnologyItem.where(name: ["HTML5", "CSS3", "JavaScript", "Sass", "Figma"]),
    backend_technologies: TechnologyItem.where(name: ["Rails", "Devise", "Cloudinary", "Postman", "PostgreSQL", "Heroku"]),
    tools: TechnologyItem.where(name: ["VSCode", "Git", "GitHub", "Slack", "Trello"]),
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  },
  {
    title: "Zero to Heroes2",
    subtitle: "Application web de location.",
    description: "Imaginez un service unique qui permet aux utilisateurs de louer des super-héros pour des événements spéciaux. Une interface intuitive combinée à une gestion fluide des réservations, conçue pour offrir une expérience inoubliable.",
    features: [
      "Espace personnel sécurisé.",
      "Gestion des réservations.",
      "Recherche basée sur la géolocalisation.",
      "Réservation à la journée ou pour plusieurs jours."
    ],
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1731125857/development/zerotohero1_ntkhgr.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    # Référence aux objets TechnologyItem par catégorie
    frontend_technologies: TechnologyItem.where(name: ["HTML5", "CSS3", "JavaScript", "Stimulus", "Sass", "Figma"]),
    backend_technologies: TechnologyItem.where(name: ["Rails", "Devise", "Cloudinary", "Postman", "PostgreSQL", "Heroku"]),
    tools: TechnologyItem.where(name: ["VSCode", "Git", "GitHub", "Slack", "Trello"]),

    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "PokéSwype2",
    subtitle: "Application web de collection.",
    description: "PokéSwype est une application web qui vous connecte à d'autres dresseurs pour échanger des cartes Pokémon et enrichir votre collection. Profitez d'un réseau social dynamique où vous pouvez discuter et négocier vos échanges en un simple glissement.",
    features: [
      "Espace personnel sécurisé.",
      "Gestion des échanges de cartes.",
      "Recherche avec Swype, basée sur la géolocalisation.",
      "Messagerie instantanée",
      "Validation des échange par QR Code",
      "Notifications en temps réel",
      "Système de notation pour renforcer la confiance."
    ],
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
    # Référence aux objets TechnologyItem par catégorie
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

  # Associer les technologies front-end
  project.frontend_technologies << project_data[:frontend_technologies].to_a

  # Associer les technologies back-end
  project.backend_technologies << project_data[:backend_technologies].to_a

  # Associer les outils
  project.tools << project_data[:tools].to_a
end

puts "Projects created!"


puts "Creating a resume..."

resume = user.create_resume!(
  title: "Mon CV",
  description: [
    "Du commerce à la tech, je crée des solutions alliant simplicité,
    esthétique et performance pour donner vie à des projets uniques.",

    "Transformer des idées en applications concrètes et explorer de nouvelles
    technologies est ce qui me pousse à aller toujours plus loin."
  ]
)

unless resume.picture.attached?
  resume.picture.attach(io: URI.open("https://res.cloudinary.com/djgk65kdl/image/upload/v1728311478/development/cv_w47x6j.png"), filename: "cv.jpg")
end

unless resume.pdf.attached?
  resume.pdf.attach(io: URI.open("https://res.cloudinary.com/djgk65kdl/image/upload/v1728311466/development/BenoitAlexandreCV_rcioqa.pdf"), filename: "BenoitAlexandreCV.pdf")
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
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306056/development/pngwing.com_rflqgf.png",
    order_position: 1
  },
  {
    diploma_name: "Bachelor Gestion et Transaction Immobilière",
    institution_name: "Institut du Management des Services Immobiliers (IMSI) - Groupe IGS",
    location: "Paris, France",
    start_date: Date.new(2016, 2),
    end_date: Date.new(2016, 10),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306069/development/logo_zhk3sf.webp",
    order_position: 2
  },
  {
    diploma_name: "Bachelor Gestionnaire d'Unité Commercial",
    institution_name: "Novancia Business School",
    location: "Paris, France",
    start_date: Date.new(2013, 2),
    end_date: Date.new(2014, 11),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306115/development/Novancia_Business_School_logo_ujzhry.png",
    order_position: 3
  },
  {
    diploma_name: "Bac Sciences et Technologies de la Gestion",
    institution_name: "Lycée René Cassin",
    location: "Arpajon, France",
    start_date: Date.new(2010, 9),
    end_date: Date.new(2011, 6),
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306115/development/academyversailles_msrk7l.png",
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
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306117/development/noduslogo_gihmsr.jpg",
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
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/development/Zara_Logo_curxt1.png",
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
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306118/development/resideetudes_ysx4tv.png",
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
    logo: "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/development/Zara_Logo_curxt1.png",
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
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306117/development/jules_klblcd.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306116/development/casa_acroll.webp",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728306119/development/logo_totalenergies_sim0jr.webp"
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
    # Si c'est un tableau de logos (plusieurs logos)
    if experience_data[:logo].is_a?(Array)
      experience_data[:logo].each_with_index do |logo_url, index|
        experience.logos.attach(io: URI.open(logo_url), filename: "logo_#{index}.jpg")
      end
    # Si c'est un seul logo (string)
    elsif experience_data[:logo].is_a?(String)
      experience.logos.attach(io: URI.open(experience_data[:logo]), filename: "logo.jpg")
    end
  end
end

puts "Experiences created!"
