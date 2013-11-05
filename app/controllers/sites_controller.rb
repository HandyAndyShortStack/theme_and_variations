class SitesController < ApplicationController

  def show
    if @site = Site.find_by_subdomain(request.subdomain)
      render_page
    else
      fail_to_render
    end
  end

private
  
  def render_page
    if @page = @site.pages.find_by_url(params[:url])
      @theme = @site.theme
      @template = @page.template
      page_template = Liquid::Template.parse(@template.liquid)
      content_for_page = page_template.render({
        "site" => @site.drop,
        "page" => @page.drop
      })
      site_template = Liquid::Template.parse(@theme.layout)
      content = site_template.render({
        "content_for_page" => content_for_page,
        "site"             => @site.drop,
        "page"             => @page.drop
      })
      render text: content
    else
      render text: "We could not find that page."
    end
  end

  def fail_to_render
    render text: "The site failed to render."
  end
end
