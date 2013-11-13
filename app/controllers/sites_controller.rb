class SitesController < ApplicationController
  include ThemesHelper

  def show
    sync_testing_themes
    if @site = Site.find_by_subdomain(request.subdomain)
      render_page
    else
      fail_to_render
    end
  end

private

  def render_page
    register_liquid_tags
    params[:url] ||= "index"
    if @page = @site.pages.find_by_url(params[:url])
      @theme = @site.theme
      @template = @page.template
      render text: content
    else
      render text: "We could not find that page."
    end
  end

  def content
    site_template = Liquid::Template.parse(@theme.layout)
    content = site_template.render({
      "content_for_page" => content_for_page,
      "site"             => @site.drop,
      "page"             => @page.drop,
      "theme"            => @theme.drop
    }, filters: [
      @theme.drop.filter_module
    ])
  end

  def content_for_page
    page_template = Liquid::Template.parse(@template.liquid)
    page_template.render({
      "site" => @site.drop,
      "page" => @page.drop
    }, filters: [
      @theme.drop.filter_module
    ])
  end

  def fail_to_render
    render text: "The site failed to render."
  end

  def register_liquid_tags
    Liquid::Template.register_tag("sandbox", SandboxTag)
  end
end
