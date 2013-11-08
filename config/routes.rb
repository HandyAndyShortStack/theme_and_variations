ThemeAndVariations::Application.routes.draw do
  constraints(lambda { |r|
      r.subdomain.present? &&
      r.subdomain != "www" &&
      r.domain != 'herokuapp.com' }) do
    get "/:url", to: "sites#show", as: :page_link
    get "/assets/:asset", to: "application#get_asset"
    get "", to: "sites#show", as: :show_site
  end
end
