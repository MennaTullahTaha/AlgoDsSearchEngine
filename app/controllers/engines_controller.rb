require 'open-uri'
require 'nokogiri'
require 'uri'

class EnginesController < ApplicationController
    include WebCrawler
    def index
        trigger_crawler
    end 

end 