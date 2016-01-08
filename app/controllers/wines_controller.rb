class WinesController < ApplicationController
  def index
    @wines = Wine.all
  end

  def new
    @wine = Wine.new
    @varietals = Varietal.all
    @vineyards = Vineyard.all
    @appellations = Appellation.all
  end
end
