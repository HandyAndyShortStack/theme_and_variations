require "spec_helper"

describe Theme do

  SAMPLE_THEME_URI = "https://s3-us-west-2.amazonaws.com/theme-and-variations/sample-theme"
  let(:theme) { Theme.new }

  before :each do
    theme.stub(uri: SAMPLE_THEME_URI)
    theme.stub_chain(:templates, :create)
    theme.templates.stub(:find_by_path)
  end

  describe "#sync" do

    context "if theme is valid" do

      it "syncs names" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:name]).to eq("sample-theme")
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs URIs" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:uri]).to eq(SAMPLE_THEME_URI)
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs styles" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:styles]).to eq(["assets/style.css.liquid"])
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs javascripts" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:javascripts]).to eq(["assets/main.js"])
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs images" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:images]).to eq(["assets/image.png"])
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "syncs the layout" do
        theme.stub(:update_attributes) do |hsh|
          expect(hsh[:layout]).to eq(HTTParty.get("#{SAMPLE_THEME_URI}/layout/theme.liquid").body)
        end
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme).to have_received(:update_attributes)
      end

      it "builds templates for each liquid file" do
        theme.stub(:update_attributes)
        theme.sync("sample-theme", "theme-and-variations")
        expect(theme.templates).to have_received(:create).with({
          path: "templates/index.liquid",
          liquid: HTTParty.get("#{SAMPLE_THEME_URI}/templates/index.liquid").body
        })
      end

      it "syncs templates that already exist" do
        template = Template.new
        template.stub(:update_attributes)
        theme.templates.stub(:find_by_path).and_return(template)
        theme.sync("sample-theme", "theme-and-variations")
        expect(template).to have_received(:update_attributes).with({
          path: "templates/index.liquid",
          liquid: HTTParty.get("#{SAMPLE_THEME_URI}/templates/index.liquid").body
        })
      end
    end

    it "does nothing if the theme is invalid", :focus => true do
      expect(theme.sync("invalid-theme", "theme-and-variations")).to be(false)
    end
  end
end
