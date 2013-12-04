module ThemesHelper
  def sync_testing_themes
    testing_theme_names = Dir.entries("#{Rails.root.to_s}/themes") - [".", ".."]
    TestingTheme.all.each { |theme| theme.destroy unless testing_theme_names.include? theme.name }
    testing_theme_names.each do |name|
      theme = TestingTheme.find_or_create_by_name(name)
      site = theme.sites.find_or_create_by_subdomain(name)
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
      testing_template_names = Dir.entries("#{Rails.root.to_s}/themes/#{name}/templates").-([".", ".."]).map do |file_name|
        file_name.sub ".liquid", ""
      end
      site.pages.each { |page| page.destroy unless testing_template_names.include? page.url }
      theme.templates.each do |template|
        page = site.pages.find_or_create_by_url(template.name)
        page.update_attributes({
          template_id: template.id,
          url:         template.name,
          title:       "Sample Page",
          options: {}
        })
      end
    end
  end
end
