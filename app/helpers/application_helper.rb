module ApplicationHelper
  def display_for(role_name)
    yield if current_user.roles.include? Role.where(name: role_name).first
  end
end
