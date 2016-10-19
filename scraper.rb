#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'

require_rel 'lib'

require 'open-uri/cached'
# require 'scraped_page_archive/open-uri'

LIST_PAGE = 'http://jamaica-elections.com/general/2016/info/constituency.php'

data = ConstituencyList.new(url: LIST_PAGE).to_h
warn "Found #{data[:constituencies].count} constituencies"

data[:constituencies].each do |mem|
  ConstituencyPage.new(id: mem[:id]).to_h[:candidates].each do |c|
    ScraperWiki.save_sqlite(%i(name constituency party), c)
  end
end
