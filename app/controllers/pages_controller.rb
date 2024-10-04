class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @admin_user = User.find_by(admin: true)
    @projects = Project.all
    @contact = Contact.new
  end

  def about
  end
end
