theme = Theme.find_by_uri("https://s3-us-west-2.amazonaws.com/theme-and-variations/checked-theme")
theme = Theme.create unless theme
theme.sync "checked-theme", "theme-and-variations"

site = Site.find_by_subdomain("sample-site") || Site.create
site.update_attributes({
  subdomain:     "sample-site",
  theme_id:      theme.id,
  options: {
    title:       "Sample Site",
    meta_tags:   "<meta name='robots' content='noindex, nofollow'>",
    custom_css:  "https://s3-us-west-2.amazonaws.com/theme-and-variations/stubs/style.css",
    closing_tag: "<div id='closing-tag'></div>",
    gac:         "<div id='gac'></div>",
    gwt:         "<div id='gwt'></div>",
    description: "sample description"
  }
})

page = site.pages.find_by_url("sample-url") || site.pages.create
page.update_attributes({
  template_id: theme.templates.first.id,
  url:         "sample-url",
  title:       "Sample Page",
  options: {}
})

testing_theme_names = Dir.entries("#{Rails.root.to_s}/themes") - [".", ".."]
TestingTheme.all.each { |theme| theme.destroy unless testing_theme_names.include? theme.name }
testing_theme_names.each do |name|
  theme = TestingTheme.find_by_name(name) || TestingTheme.create(name: name)
  site = theme.sites.find_by_subdomain(name) || theme.sites.create
  site.update_attributes({
    subdomain:     name,
    theme_id:      theme.id,
    options: {
      title:       "Sample Site",
      meta_tags:   "<meta name='robots' content='noindex, nofollow'>",
      custom_css:  "https://s3-us-west-2.amazonaws.com/theme-and-variations/stubs/style.css",
      closing_tag: "<script type='text/javascript'>// additional closing tags here</script>",
      gac:         "<script type='text/javascript'>// google analytics tracking here</script>",
      gwt:         "<meta name='google-site-verification' content='string_google_asks_for'>",
      description: "sample description"
    }
  })
  theme.templates.each do |template|
    page = site.pages.find_by_url(template.name) || site.pages.create
    page.update_attributes({
      template_id: template.id,
      url:         template.name,
      title:       "Sample Page",
      options: {}
    })
  end
end
