class StocksController < ApplicationController

  def search
    if params[:stock]
      puts %Q[Value of stock name eneterd is #{params[:stock]}]
      @stock = Stock.find_by_ticker(params[:stock]) 
      
      if @stock
        puts "Stocks by find_by_ticker is null"
      else
        
        puts "Stocks by find_by_ticker is not null"
        puts 
      end
      #if  @stock
      #  puts "Stock find by Tickler"
      #else
      #  puts "Stock not find by Tickler - Going by Name"
      #  @stock = Stock.where("name LIKE ?", "%#{params[:stock]}%")
      #end
      
      @stock ||= Stock.new_from_lookup(params[:stock])
    end
    
    if @stock
      puts "Stock found"
      #puts @stock.ticker + @stock.name 
      #render json: @stock
      render partial: 'lookup'
    else
      puts "Stock not found"
      render status: :not_found, nothing: true
    end
  end
  
  def detail
    puts "Horray - Reached Detail Page - Now show me Detail Boss"
  end
  
end
