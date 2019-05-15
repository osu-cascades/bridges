module ApplicationHelper

  def sign_in_or_out_link
    if signed_in?
      link_to 'Sign Out', destroy_user_session_path, method: :delete, class: 'nav-link'
    else
      link_to 'Sign In', new_user_session_path, class: 'nav-link'
    end
  end

  def form_errors_for(object)
    render partial: 'shared/form_errors', locals: { object: object }
  end

  def content_for_title(title)
    provide(:title, title)
    content_for(:screen_title) { content_tag(:h1) { title } }
  end

end
