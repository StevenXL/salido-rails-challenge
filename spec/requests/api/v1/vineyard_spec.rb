require 'rails_helper'

RSpec.describe "Vineyard API", type: :request do
  before(:each) do
    create_list(:vineyard, 10)
  end

  context "get a list of all vineyards" do

    it "should return status 200" do
      get api_v1_vineyards_path
      expect(response).to be_success
    end

    it "should return all the vineyards in the database" do
      get api_v1_vineyards_path

      json = JSON.parse(response.body)

      expect(json.count).to eq(10)
    end
  end

  context "get one vineyard type" do
    let(:single_vineyard) { Vineyard.first }

    before(:each) do
      get api_v1_vineyard_path(single_vineyard)
    end

    it "should return a status 200" do
      expect(response).to be_success
    end

    it "should return a valid JSON representation of vineyard" do
      expect(response).to match_response_schema("vineyard")
    end
  end

  context "create a vineyard" do
    context "with valid attributes" do
      let(:attrs_json_hash) { build(:vineyard).to_json }

      it "should return status 200" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/vineyards", "#{attrs_json_hash}", headers

        expect(response).to be_success
      end

      it "should create a new vineyard" do
        headers = { "CONTENT_TYPE" => "application/json" }

        expect{
          post "/api/v1/vineyards", "#{attrs_json_hash}", headers
        }.to change{Vineyard.count}.from(10).to(11)
      end
    end

    context "with invalid attributes" do
      it "should return status code 422" do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/api/v1/vineyards", "#{{vineyard: {name: ''}}.to_json}", headers

        expect(response).to have_http_status(422)
      end

      it "should not change number of vineyards  in database" do
        headers = { "CONTENT_TYPE" => "application/json" }
        expect{
          post "/api/v1/vineyards", "#{{vineyard: {name: ''}}.to_json}", headers
        }.not_to change{Vineyard.count}
      end
    end
  end

  context "update a vineyard" do
    let(:id) { Vineyard.first.id }

    it "should update a vineyard" do
      headers = { "CONTENT_TYPE" => "application/json" }
      put "/api/v1/vineyards/#{id}", '{"vineyard": {"name":"Other Amber Gold Blends"}}', headers
      expect(Vineyard.find(id).name).to eq("Other Amber Gold Blends")
    end
  end

  context "delete a vineyard" do
    it "should delete a vineyard" do
      expect{
        delete "/api/v1/vineyards/#{Vineyard.first.id}"
      }.to change{Vineyard.count}.from(10).to(9)
    end
  end
end
