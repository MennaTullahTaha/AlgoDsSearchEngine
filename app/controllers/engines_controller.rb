# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'uri'

class EnginesController < ApplicationController
  include WebCrawler
  def home; end

  def search
    session[:user_id] = nil
    populate_db
    choice = params[:engine][:choice]
    search_value = params[:engine][:search_value]
    flash.now[:notice] = 'Here are the results for your search'
    @results = if choice == 'Algorithm'
                 Algorithm.search(search_value)
               else
                 Datastructure.search(search_value)
               end
    @results
  end

  private

  def populate_db
    if Algorithm.none? && Datastructure.none?
      algos, ds = trigger_crawler
      algos.each do |attrs|
        algo = Algorithm.new(attrs)
        algo.save unless Algorithm.find_by(title: attrs.title)
      end
      ds.each do |attrs|
        data_structure = Datastructure.new(attrs)
        data_structure.save unless Algorithm.find_by(title: attrs.title)
      end
    end
  end
end
