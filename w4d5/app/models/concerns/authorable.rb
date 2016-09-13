module Authorable
  extend ActiveSupport::Concern

  def check_for_admin! id
    self.user.id == id
  end
end
