require 'rails_helper'

RSpec.describe "Varietal API", type: :request do
  before(:each) do
    create_list(:varietal, 10)
  end

  context "get a list of all varietals" do

    it "should return status 200" do
      get api_v1_varietals_path
      expect(response).to be_success
    end

    it "should return all the varietals in the database" do
      get api_v1_varietals_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one varietal type" do
    let(:single_varietal) { Varietal.first }

    before(:each) do
      get api_v1_varietal_path(single_varietal)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of varietal" do
      expect(response).to match_response_schema("varietal")
    end
  end

  context "create a varietal" do
    context "with valid attributes" do
      let(:attrs_json_hash) { build(:varietal).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/varietals", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new varietal" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/varietals", "#{attrs_json_hash}", headers
        }.to change{Varietal.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/varietals", "#{{varietal: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of varietals  in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/varietals", "#{{varietal: {name: ''}}.to_json}", headers
        }.not_to change{Varietal.count}
      end
    end
  end

  context "update a varietal" do
    let(:id) { Varietal.first.id }

    it "should update a varietal" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/varietals/#{id}", '{"varietal": {"name":"Other Amber Gold Blends"}}', headers
      expect(Varietal.find(id).name).to eq("Other Amber Gold Blends")
    end
  end

  context "delete a varietal" do
    it "should delete a varietal" do
      expect{
        delete "/api/v1/varietals/#{Varietal.first.id}"
      }.to change{Varietal.count}.from(10).to(9)
    end
  end
end
