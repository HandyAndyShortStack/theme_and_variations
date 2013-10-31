require "spec_helper"

describe Theme do

  let(:theme) { Theme.new }

  describe "#sync" do
    context "if index.liquid is present" do
      it "syncs names"
      it "syncs styles"
      it "syncs javascripts"
      it "syncs asset URIs"
      it "syncs the layout"
      it "builds templates for each liquid file"
      it "syncs templates that already exist"
    end
    it "does nothing if index.liquid is not present"
  end
  describe "#styles" do
    it "gathers stylesheets into an array"
  end
  describe "#sync_javascripts" do
    it "gathers javascripts into an array"
  end
end
