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
Resume.destroy_all
Education.destroy_all
Experience.destroy_all


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
    description: "Imaginez un service unique qui permet aux utilisateurs de louer des super-héros pour des événements spéciaux. Une interface intuitive combinée à une gestion fluide des réservations, conçue pour offrir une expérience inoubliable.",
    features: [
      "Accès à un espace personnel sécurisé avec authentification et création de compte simplifiée.",
      "Gestion des réservations passées, en cours et futures, ainsi que des propres super-héros disponibles à la location.",
      "Recherche avancée de super-héros basée sur la géolocalisation pour trouver des héros près de chez vous.",
      "Possibilité de réserver à la journée ou sur plusieurs jours, selon vos besoins."
    ],
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728655503/development/zerotohero1_axbno3.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku",
    frontend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/html5_kf7hmz.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/css3_q9lv1h.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/js_qh6ndw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/figma_d7mc4z.png"
    ],
    backend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/rails_w8dl1x.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/postgresql_czwsff.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/heroku_vqw6qd.png"
    ],
    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "Pokéswype",
    description: "This is a Pokémon game. I built it with JavaScript.",
    features: [
      "Accès à un espace personnel sécurisé avec authentification et création de compte simplifiée.",
      "Gestion des réservations passées, en cours et futures, ainsi que des propres super-héros disponibles.",
      "Recherche avancée de super-héros basée sur la géolocalisation pour trouver des héros près de chez vous.",
      "Possibilité de réserver à la journée ou sur plusieurs jours, selon vos besoins."
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
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku, QRcode, PokeAPI, messenger",
    frontend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/html5_kf7hmz.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/css3_q9lv1h.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/js_qh6ndw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/figma_d7mc4z.png"
    ],
    backend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/rails_w8dl1x.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/postgresql_czwsff.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/heroku_vqw6qd.png"
    ],
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  },
  {
    title: "Zero to Heroes",
    description: "Imaginez un service unique qui permet aux utilisateurs de louer des super-héros pour des événements spéciaux. Une interface intuitive combinée à une gestion fluide des réservations, conçue pour offrir une expérience inoubliable.",
    features: [
      "Accès à un espace personnel sécurisé avec authentification et création de compte simplifiée.",
      "Gestion des réservations passées, en cours et futures, ainsi que des propres super-héros disponibles à la location.",
      "Recherche avancée de super-héros basée sur la géolocalisation pour trouver des héros près de chez vous.",
      "Possibilité de réserver à la journée ou sur plusieurs jours, selon vos besoins."
    ],
    pictures: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1728655503/development/zerotohero1_axbno3.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.27_ju3ccf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718195/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.28.53_ayjjuf.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727718194/development/Capture_d_e%CC%81cran_2024-04-05_a%CC%80_15.29.28_cirhek.png"
    ],
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku",
    frontend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/html5_kf7hmz.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/css3_q9lv1h.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/js_qh6ndw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/figma_d7mc4z.png"
    ],
    backend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/rails_w8dl1x.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/postgresql_czwsff.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/heroku_vqw6qd.png"
    ],
    link: "https://github.com/Chorusgrey/zero_to_heroes",
    dev_count: 5
  },
  {
    title: "Pokéswype",
    description: "This is a Pokémon game. I built it with JavaScript.",
    features: [
      "Accès à un espace personnel sécurisé avec authentification et création de compte simplifiée.",
      "Gestion des réservations passées, en cours et futures, ainsi que des propres super-héros disponibles.",
      "Recherche avancée de super-héros basée sur la géolocalisation pour trouver des héros près de chez vous.",
      "Possibilité de réserver à la journée ou sur plusieurs jours, selon vos besoins."
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
    technologies: "Ruby on Rails, HTML, CSS, JavaScript, PostgreSQL, Heroku, QRcode, PokeAPI, messenger",
    frontend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/html5_kf7hmz.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/css3_q9lv1h.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/js_qh6ndw.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/figma_d7mc4z.png"
    ],
    backend_technologies: [
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/rails_w8dl1x.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700624/development/postgresql_czwsff.png",
      "https://res.cloudinary.com/djgk65kdl/image/upload/v1727700623/development/heroku_vqw6qd.png"
    ],
    link: "https://github.com/Benalta7892/pokeswype",
    dev_count: 5
  }

]

projects.each do |project_data|
  project = user.projects.create!(
    title: project_data[:title],
    description: project_data[:description],
    features: project_data[:features],
    technologies: project_data[:technologies],
    frontend_technologies: project_data[:frontend_technologies],
    backend_technologies: project_data[:backend_technologies],
    link: project_data[:link],
    dev_count: project_data[:dev_count]
  )

  if project_data[:pictures] && !project.pictures.attached?
    project_data[:pictures].each_with_index do |picture_url, index|
      project.pictures.attach(io: URI.open(picture_url), filename: "picture_#{index}.jpg")
    end
  end
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
