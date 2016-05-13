class WikiPolicy < ApplicationPolicy
  def edit?
  	user.present? && (record.user == user || user.admin?)
  end

  def destroy?
  	edit?
  end
end
