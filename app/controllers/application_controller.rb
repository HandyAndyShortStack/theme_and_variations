class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_asset
    render text: File.open("#{Rails.root}/themes/#{request.subdomain}/assets/#{params[:asset]}.#{params[:format]}").read
  end
end
