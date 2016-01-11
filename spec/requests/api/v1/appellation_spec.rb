require 'rails_helper'

RSpec.describe "Appellation API", type: :request do
  before(:each) do
    create_list(:appellation, 10)
  end

  context "get a list of all appellations" do

    it "should return status 200" do
      get api_v1_appellations_path
      expect(response).to be_success
    end

    it "should return all the appellations in the database" do
      get api_v1_appellations_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one appellation type" do
    let(:single_appellation) { Appellation.first }

    before(:each) do
      get api_v1_appellation_path(single_appellation)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of appellation" do
      expect(response).to match_response_schema("appellation")
    end
  end

  context "create a appellation" do
    context "with valid attributes" do
      let(:attrs_json_hash) { build(:appellation).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/appellations", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new appellation" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/appellations", "#{attrs_json_hash}", headers
        }.to change{Appellation.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/appellations", "#{{appellation: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of appellations  in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/appellations", "#{{appellation: {name: ''}}.to_json}", headers
        }.not_to change{Appellation.count}
      end
    end
  end

  context "update a appellation" do
    let(:id) { Appellation.first.id }

    it "should update a appellation" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/appellations/#{id}", '{"appellation": {"name":"Other Amber Gold Blends"}}', headers
      expect(Appellation.find(id).name).to eq("Other Amber Gold Blends")
    end
  end

  context "delete a appellation" do
    it "should delete a appellation" do
      expect{
        delete "/api/v1/appellations/#{Appellation.first.id}"
      }.to change{Appellation.count}.from(10).to(9)
    end
  end
end
