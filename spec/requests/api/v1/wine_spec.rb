require 'rails_helper'

RSpec.describe "Wine API", type: :request do
  before(:each) do
    create_list(:wine, 10)
  end

  context "get a list of all wines" do

    it "should return status 200" do
      get api_v1_wines_path
      expect(response).to be_success
    end

    it "should return all the wines in the database" do
      get api_v1_wines_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one wine type" do
    let(:single_wine) { Wine.first }

    before(:each) do
      get api_v1_wine_path(single_wine)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of wine" do
      expect(response).to match_response_schema("wine")
    end
  end

  context "create a wine" do
    context "with valid attributes" do
      let(:attrs_json_hash) { build(:wine).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/wines", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new wine" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/wines", "#{attrs_json_hash}", headers
        }.to change{Wine.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/wines", "#{{wine: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of wines  in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/wines", "#{{wine: {name: ''}}.to_json}", headers
        }.not_to change{Wine.count}
      end
    end
  end

  context "update a wine" do
    let(:id) { Wine.first.id }

    it "should update a wine" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/wines/#{id}", '{"wine": {"name":"Other Amber Gold Blends"}}', headers
      expect(Wine.find(id).name).to eq("Other Amber Gold Blends")
    end
  end

  context "delete a wine" do
    it "should delete a wine" do
      expect{
        delete "/api/v1/wines/#{Wine.first.id}"
      }.to change{Wine.count}.from(10).to(9)
    end
  end
end
