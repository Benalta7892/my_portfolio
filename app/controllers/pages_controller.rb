class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @admin_user = User.find_by(admin: true)
    @projects = Project.order(created_at: :asc)
    @contact = Contact.new
    @resume = Resume.find_by(user: @admin_user)
  end

  def about
    @admin_user = User.find_by(admin: true)
    @resume = Resume.find_by(user: @admin_user)

    return unless @resume

    @educations = @resume.educations.order(order_position: :asc)
    @experiences = @resume.experiences.order(order_position: :asc)
  end
end
