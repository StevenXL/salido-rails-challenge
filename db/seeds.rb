class DatabaseSeeder
  attr_reader :api_key
  def initialize(api_key)
    @api_key = api_key
  end

  def seed_database
    if data.response.is_a?(Net::HTTPOK)
      product_list = JSON.parse(data.body)["Products"]["List"]
      add_data_to_database(product_list)
    else
      puts "Unable to grab data from Wine.com API"
    end
  end

  private

  def endpoint
    "http://services.wine.com/api/beta2/service.svc/json//catalog?filter=categories(490+124)&offset=10&size=100&apikey=#{api_key}"
  end

  def data
    HTTParty.get endpoint
  end

  def add_data_to_database(product_list)
    product_list.each do |product|
      add_product_to_database(product)
    end
  end

  def add_product_to_database(product)
    region = product["Appellation"]["Region"] ? create_or_find_region(product["Appellation"]["Region"]) : nil
    appellation = product["Appellation"] ? create_or_find_appellation(product["Appellation"], region) : nil
    winetype = product["Varietal"]["WineType"] ? create_or_find_winetype(product["Varietal"]["WineType"]) : nil
    varietal = product["Varietal"] ? create_or_find_varietal(product["Varietal"], winetype) : nil
    name = product["Name"]
    price_max = product["PriceMax"]
    price_min = product["PriceMin"]
    price_retail = product["PriceRetail"]
    vineyard = product["Vineyard"] ? create_or_find_vineyard(product["Vineyard"]) : nil
    year = product["Year"] || ""

    wine = Wine.find_or_create_by!(name: name,
                       price_min: price_min,
                       price_max: price_max,
                       price_retail: price_retail,
                       appellation: appellation,
                       year: year,
                       varietal: varietal,
                       vineyard: vineyard)

    attach_winetraits(wine, product["ProductAttributes"])
  end

  def attach_winetraits(wine, traits_list)
    traits = find_traits(traits_list)

    traits.each do |trait|
      WineTrait.create!(wine: wine, trait: trait)
    end
  end

  def find_traits(traits_list)
    traits_list.map do |trait|
      unescaped_name = CGI.unescapeHTML(trait["Name"])
      Trait.find_or_create_by(name: unescaped_name)
    end
  end

  def create_or_find_vineyard(vineyard_hash)
    prepared_hash = clean_hash(vineyard_hash, "Name")
    Vineyard.find_or_create_by!(prepared_hash)
  end

  def create_or_find_varietal(varietal_hash, winetype)
    prepared_hash = clean_hash(varietal_hash, "Name").merge(wine_type_id: winetype.id)
    Varietal.find_or_create_by!(prepared_hash)
  end

  def create_or_find_winetype(winetype_hash)
    prepared_hash = clean_hash(winetype_hash, "Name")
    WineType.find_or_create_by!(prepared_hash)
  end

  def create_or_find_appellation(appellation_hash, region)
    prepared_hash = clean_hash(appellation_hash, "Name").merge({region_id: region.id})
    Appellation.find_or_create_by!(prepared_hash)
  end

  def create_or_find_region(region_hash)
    prepared_hash = clean_hash(region_hash, "Name")
    Region.find_or_create_by!(prepared_hash)
  end

  def clean_hash(hash, *keys)
    transform_keys(whitelist_hash(hash, *keys))
  end

  def whitelist_hash(hash, *keys)
    hash.keys.each do |key|
      hash.delete(key) unless keys.include?(key)
    end

    hash
  end

  def transform_keys(hash)
    hash.each_with_object({}) do |(key, value), transformed|
      key = key.downcase.to_sym
      transformed[key] = value
    end
  end
end

seeder = DatabaseSeeder.new(ENV['WINE_API_KEY'])
seeder.seed_database
