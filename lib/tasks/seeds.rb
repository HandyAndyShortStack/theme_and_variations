theme = Theme.find_by_uri("https://s3-us-west-2.amazonaws.com/theme-and-variations/checked-theme")
theme = Theme.create unless theme
theme.sync "checked-theme", "theme-and-variations"

site_attributes = {
  subdomain:     "sample-site",
  theme_id:      theme.id,
  options: {
    title:       "Sample Site",
    meta_tags:   "<meta name='robots' content='noindex, nofollow'>",
    custom_css:  "style.css",
    closing_tag: "<div id='closing-tag'></div>",
    gac:         "<div id='gac'></div>",
    gwt:         "<div id='gwt'></div>",
    description: "sample description"
  }
}
site = Site.find_by_subdomain("sample-site") || Site.create
site.update_attributes(site_attributes)

