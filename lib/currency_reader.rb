require 'open-uri'
require 'nokogiri'

module CurrencyReader
  module_function

  URL = 'http://www.cbr.ru/scripts/XML_daily.asp'.freeze
  CURRENCY = {usd: 'R01235'}

  def read_currency_from_url
    doc = Nokogiri::XML(URI.open(URL))

    doc.xpath("//ValCurs/Valute[@ID='#{CURRENCY[:usd]}']/Value").text.gsub(',', '.').to_f.round(2)
  end
end
