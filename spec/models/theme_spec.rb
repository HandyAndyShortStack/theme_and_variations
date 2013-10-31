require "spec_helper"

describe Theme do

  SAMPLE_THEME_URI = "https://s3-us-west-2.amazonaws.com/theme-and-variations/sample-theme"
  let(:theme) { Theme.new }

  describe "#sync" do

    context "if theme is valid" do

      it "syncs names" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:name]).to eq("sample-theme")
        end
        theme.sync(SAMPLE_THEME_URI)
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs URIs" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:uri]).to eq(SAMPLE_THEME_URI)
        end
        theme.sync(SAMPLE_THEME_URI)
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs styles" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:styles]).to eq([SAMPLE_THEME_URI + "/assets/style.css"])
        end
        theme.sync(SAMPLE_THEME_URI)
        expect(theme).to have_received(:update_attributes)
      end
      it "syncs javascripts"
      it "syncs images"
      it "syncs the layout"
      it "builds templates for each liquid file"
      it "syncs templates that already exist"
    end
    it "does nothing if the theme is invalid"
  end
  describe "#styles" do
    it "gathers stylesheets into an array"
  end
  describe "#sync_javascripts" do
    it "gathers javascripts into an array"
  end
end
