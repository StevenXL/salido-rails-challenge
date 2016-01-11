require 'rails_helper'

RSpec.describe "Wine Type API", type: :request do
  before(:each) do
    create_list(:wine_type, 10)
  end

  context "get a list of all wine types" do

    it "should return status 200" do
      get api_v1_wine_types_path
      expect(response).to be_success
    end

    it "should return all the wine types in the database" do
      get api_v1_wine_types_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one wine type" do
    let(:single_wine_type) { WineType.first }

    before(:each) do
      get api_v1_wine_type_path(single_wine_type)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of a wine type" do
      expect(response).to match_response_schema("wine_type")
    end
  end

  context "create a wine type" do
    context "with valid attributes" do
      let(:attrs_json_hash) { attributes_for(:wine_type).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/wine_types", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new wine type" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/wine_types", "#{attrs_json_hash}", headers
        }.to change{WineType.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/wine_types", "#{{wine_type: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of Wine Types in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/wine_types", "#{{wine_type: {name: ''}}.to_json}", headers
        }.not_to change{WineType.count}
      end
    end
  end

  context "update a wine type" do
    let(:id) { WineType.first.id }

    it "should update a wine type" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/wine_types/#{id}", '{"wine_type": {"name":"Amber Gold"}}', headers
      expect(WineType.find(id).name).to eq("Amber Gold")
    end
  end

  context "delete a wine type" do
    it "should delete a wine type" do
      expect{
        delete "/api/v1/wine_types/#{WineType.first.id}"
      }.to change{WineType.count}.from(10).to(9)
    end
  end
end
