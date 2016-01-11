require 'rails_helper'

RSpec.describe "Region API", type: :request do
  before(:each) do
    create_list(:region, 10)
  end

  context "get a list of all regions" do

    it "should return status 200" do
      get api_v1_regions_path
      expect(response).to be_success
    end

    it "should return all the regions in the database" do
      get api_v1_regions_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one region type" do
    let(:single_region) { Region.first }

    before(:each) do
      get api_v1_region_path(single_region)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of region" do
      expect(response).to match_response_schema("region")
    end
  end

  context "create a region" do
    context "with valid attributes" do
      let(:attrs_json_hash) { build(:region).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/regions", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new region" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/regions", "#{attrs_json_hash}", headers
        }.to change{Region.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/regions", "#{{region: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of regions  in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/regions", "#{{region: {name: ''}}.to_json}", headers
        }.not_to change{Region.count}
      end
    end
  end

  context "update a region" do
    let(:id) { Region.first.id }

    it "should update a region" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/regions/#{id}", '{"region": {"name":"Other Amber Gold Blends"}}', headers
      expect(Region.find(id).name).to eq("Other Amber Gold Blends")
    end
  end

  context "delete a region" do
    it "should delete a region" do
      expect{
        delete "/api/v1/regions/#{Region.first.id}"
      }.to change{Region.count}.from(10).to(9)
    end
  end
end
