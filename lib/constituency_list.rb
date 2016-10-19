# frozen_string_literal: true
require_relative 'page'

class ConstituencyList < Page
  field :constituencies do
    noko.css('#form1 #constituencyid option').drop(1).map do |opt|
      {
        id:   opt.attr('value'),
        name: opt.text.tidy,
      }
    end
  end
end
