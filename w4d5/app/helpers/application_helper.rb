module ApplicationHelper
  def auth_token
    "<input name='authenticity_token', type='hidden', method=<%= form_authenticity_token %>".html_safe
  end
end
