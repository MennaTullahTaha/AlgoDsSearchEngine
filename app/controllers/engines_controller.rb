# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'uri'

class EnginesController < ApplicationController
  include WebCrawler
  def home; end

  def search
    populate_db
    choice = params[:engine][:choice]
    search_value = params[:engine][:search_value]
    respond_to do |format|
      #-> @search will be available in the other view
      format.html do
        redirect_to display_results_path(choice: choice, search_value: search_value)
      end
    end
  end

  def display_results
    flash[:notice] = 'Here are the results for your search'
    @results = if params[:choice] == 'Algorithm'
                 Algorithm.search(params[:search_value]).paginate(page: params[:page], per_page: 5)
               else
                 Datastructure.search(params[:search_value]).paginate(page: params[:page], per_page: 5)
               end
    @results
  end

  private

  def populate_db
    if Algorithm.none? && Datastructure.none?
      algos, ds = trigger_crawler
      algos.each do |attrs|
        algo = Algorithm.new(attrs)
        algo.save unless Algorithm.find_by(url: attrs[:url])
      end
      ds.each do |attrs|
        data_structure = Datastructure.new(attrs)
        data_structure.save unless Datastructure.find_by(url: attrs[:url])
      end
    end
  end
end
