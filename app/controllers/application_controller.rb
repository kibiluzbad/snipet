class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  
  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end
  
  private
  def extract_locale_from_accept_language_header
    available = %w{en pt-BR}
    request.compatible_language_from(available)
  end
end
