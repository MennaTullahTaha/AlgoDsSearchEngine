require 'open-uri'
require 'nokogiri'
require 'uri'
require 'activerecord-import'

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
end 