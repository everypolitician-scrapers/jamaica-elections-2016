# frozen_string_literal: true

require_relative 'page'

class ConstituencyPage < Page
  field :candidates do
    candidate_tables.flat_map do |t|
      Candidate.new(url: url, noko: t, constituency: constituency).to_h
    end
  end

  field :constituency do
    noko.css('h2').text.tidy
  end

  private

  BASE = 'http://jamaica-elections.com/general/2016/info/constituency.php?constituencyid=%d'

  def url
    BASE % @h[:id]
  end

  def scope
    noko.css('.latest-news-article')
  end

  def candidate_tables
    scope.css('table')
  end
end

class Candidate < Page
  field :name do
    noko.css('.style6').text.tidy
  end

  field :image do
    absolute_url(noko.css('div[align="left"] img/@src').text).to_s
  end

  field :party do
    noko.css('.style9').text.tidy
  end

  field :constituency do
    @h[:constituency]
  end

  private

  def noko
    @h[:noko]
  end
end
