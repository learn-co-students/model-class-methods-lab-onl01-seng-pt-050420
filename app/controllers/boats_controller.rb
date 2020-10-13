class BoatsController < ApplicationController
    def index
        @boats = Boat.longest
    end

    def show
        @boat = Boat.find(params[:id])
    end
end
