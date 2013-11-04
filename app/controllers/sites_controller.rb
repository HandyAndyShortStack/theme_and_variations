class SitesController < ApplicationController

  def show
    if @site = Site.find_by_subdomain(request.subdomain)
      render_page
    else
      fail_to_render
    end
  end

private

  def fail_to_render
    render text: "The site failed to render."
  end
end
