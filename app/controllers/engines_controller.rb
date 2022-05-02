require 'open-uri'
require 'nokogiri'
require 'uri'

class EnginesController < ApplicationController
    include WebCrawler
    def index
        if !Algorithm.any? && !Datastructure.any?       
            algos, ds = trigger_crawler
            algos.each do |attrs|
                algo = Algorithm.new(attrs)
                algo.save
            end
            ds.each do |attrs|
                data_structure = Datastructure.new(attrs)
                data_structure.save
            end       
        end
    end

    def search
        choice = params[:engine][:choice]
        search_value = params[:engine][:search_value]
        flash.now[:notice] = "Here are the results for your search"
        if choice == "Algorithm"
            @results = Algorithm.search(search_value).paginate(page: params[:page], per_page: 5)
        else
            @results = Datastructure.search(search_value).paginate(page: params[:page], per_page: 5)
        end
        @results
    end
end 