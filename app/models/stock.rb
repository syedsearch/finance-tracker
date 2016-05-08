class Stock < ActiveRecord::Base
  
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.find_by_name()
  
  end

  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  

  
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    puts %Q{ Average Daily Volume is #{looked_up_stock.average_daily_volume} and Change Percent Change is #{looked_up_stock.change_percent_change}}
    return nil unless looked_up_stock.name
    
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name, daily_volume: looked_up_stock.average_daily_volume )
    new_stock.last_price = new_stock.price
    puts %Q{retrieved new_stock.average_daily_volume values are #{new_stock.daily_volume}}
    new_stock
  end
  
  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price
    
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price
    'Unavailable'
  end
end
