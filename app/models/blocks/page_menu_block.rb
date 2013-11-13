class PageMenuBlock < Block
  def pages
    self.sandbox.page.site.pages
  end
end
