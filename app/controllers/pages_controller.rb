class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @admin_user = User.find_by(admin: true)
    @projects = Project.all
    @contact = Contact.new
  end

  def about
    @admin_user = User.find_by(admin: true)
    @resume = Resume.find_by(user: @admin_user)

    return unless @resume

    @educations = @resume.educations.order(start_date: :asc)
    @experiences = @resume.experiences.order(start_date: :asc)
  end
end
