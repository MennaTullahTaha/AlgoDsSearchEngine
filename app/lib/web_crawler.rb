# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'uri'
require 'net/http'
require 'json'

# TODO: make crawler run indiffently
module WebCrawler
  def trigger_crawler
    algo_results = follow_links('https://www.geeksforgeeks.org/fundamentals-of-algorithms/', 'div#content', true)
    ds_results = follow_links('https://www.geeksforgeeks.org/data-structures/', 'div.entry-content', false)
    # replace_last_character_in_File("algorithms.json")
    # replace_last_character_in_File("data_structures.json")
    [algo_results, ds_results]
  end

  private

  ################################################## In case of wanting to create json objects
  def replace_last_character_in_File(file_name)
    File.truncate(file_name, File.size(file_name) - 1)
    File.open(file_name, 'a') do |f|
      f.write ']'
    end
  end

  def write_in_file(file_name, dict)
    if !dict.nil? && dict.length.positive?
      if !File.exist?(file_name)
        File.open(file_name, 'a') do |f|
          f.write '['
          f.write(dict.to_json)
          f.write ','
        end
      else
        File.open(file_name, 'a') do |f|
          f.write(dict.to_json)
          f.write ','
        end
      end
    end
  end

  #####################################################
  def follow_links(url, element, algorithms_flag)
    algo_results = []
    ds_results = []
    doc = is_link_valid?(url)
    if doc
      content = doc.css(element)
      links = content.css('a').map { |link| link['href'] }.compact
      crawler_results = construct_links(links, url)
      crawler_results.each do |result|
        new_doc = is_link_valid?(result)
        if new_doc
          if algorithms_flag
            result = get_algorithm_details(result, new_doc)
            algo_results.append(result) if result
          # write_in_file("algorithms.json", result )
          else
            result = get_data_structure_details(result, new_doc)
            ds_results.append(result) if result
            # write_in_file("data_structures.json", result)
          end
        else
          crawler_results.delete_if { |x| x == result }
        end
      end
      if algorithms_flag
        algo_results
      else
        ds_results
      end
    end
  end

  def is_link_valid?(url)
    begin
      doc = Nokogiri::HTML(open(url))
    rescue StandardError
      return false
    end
    doc
  end

  def get_algorithm_details(url, doc)
    title = doc.at_css('title').text

    page_content = doc.css('div.article--viewer_content')
    content = page_content.css('p').map(&:text).compact

    time_complexity_occurances = page_content.css('p').select do |value|
      value.text.downcase.include?('time complexity')
    end
    time_complexity = []
    time_complexity_occurances.each do |element|
      time_complexity.append(element.text)
    end
    if time_complexity.length.positive?
      { 'url' => url, 'title' => title,
        'time_complexity' => time_complexity.join(' ') }
    end
  end

  def get_data_structure_details(url, doc)
    title = doc.at_css('title').text

    page_content = doc.css('div.article--viewer_content')
    content = page_content.css('p').map(&:text).compact

    { 'url' => url, 'title' => title, 'content' => content.join(' ') } if content.length.positive?
  end

  def construct_links(links, url)
    resulted_links = []
    uri = URI.parse(url)
    current_url = "#{uri.scheme}://#{uri.host}"
    links.delete_if(&:nil?)
    result = ''
    links.each do |link|
      if link.include?('javascript:') || link[0] == '#'
        next
      else
        result = fix_links(link, current_url, uri)
      end

      resulted_links.append(result) unless resulted_links.include?(result)
    end
    resulted_links
  end

  def fix_links(link, current_url, uri)
    result = link
    # in case of link format '/example'
    if link[0] == '/' && link[1] != '/'
      result = current_url + link
    # in case of link format '//www.google.com/hello'
    elsif link[0..1] == '//'
      result = "#{uri.scheme}:#{link}"
    # in case of link format "./example.html"
    elsif link[0..1] == './'
      result = current_url + link[1..link.length]
    # in case of link format '../exmaple.rb'
    elsif link[0..2] == '../'
      result = "#{current_url}/#{link}"
    else
      # in case of link format "example.rb"
      tmp_uri = URI.parse(link)
      result = "#{current_url}/#{link}" if tmp_uri.scheme != 'https' && tmp_uri.scheme != 'http'
    end
    result
  end
end
