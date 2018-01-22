class CryptoQuote::CLI	
	@@ticker = CryptoQuote::Ticker.new.data
	

	def call
		welcome
		list_crypto_currencies
		get_selection_input
	end

	def welcome
		puts "Welcome to the Cryto Quote App."
		puts "The quotes are from http://coinmarketcap.com and are delayed by 15 minutes."
	end
	
	# | Rank		| Ticker  | Name		  | Price      | % 1 Hour | % 24 Hours |
	# | --------| --------| --------  | -----------|----------| -----------|
	# | 1				|	BTC			|	Bitcoin	  |	$10,730.7	 | 1.1%			|	-6.73%     |
	# | 2				|	ETH			|	Ethereum	|	$987.32		 | 1.6%			|	-5.32%		 |
	

	def list_crypto_currencies
		puts "type the number of the crypto currency to see more information"
		puts "Type exit to exit"
		rows = []
		puts ""
		self.ticker.each{|c| rows << [c['rank'], c["symbol"], c["name"], c['price_usd'], c['percent_change_1h']+"%", c['percent_change_24h']+"%"]}
		table = Terminal::Table.new :title => "Crypto Quotes", :headings => ['Rank', 'Ticker', 'Name', 'Price', '1 Hr %', '24 Hr %'], :rows => rows
		puts table
	end

	def get_selection_input
		input = gets.strip
		if valid_input?(input)
			if input == "exit"
				goodbye
				exit
			elsif input == "l" || input == "list"
				list_crypto_currencies
				get_selection_input
			else
				crypto_detail(input)
			end
		end
	end

	def ticker
		@@ticker
	end

	def ticker_count
		@@ticker.count
	end

	def valid_input?(input)
		input == "exit" || input == "l" || input == "list" || (input.to_i > 0 && input.to_i <= ticker_count) ? true : false
	end

	def crypto_detail(input)
		c = ticker[input.to_i - 1]
		available_percent = ((c['available_supply'].to_f / c['max_supply'].to_f)*100).round(2)

		price = currency_format(c['price_usd'])
		market_cap = currency_format(c['market_cap_usd'])
		daily_vol = currency_format(c['24h_volume_usd'])
		available_supply = currency_format(c['available_supply'])
		max_supply = currency_format(c['max_supply'])
		

		row1 = []
		row1 << [ c['symbol'], price, c['percent_change_1h']+'%', c['percent_change_24h']+'%', c['percent_change_7d']+'%' ]
		table1 = Terminal::Table.new :title => "#{c['name']} Details", :headings => ['Symbol', 'Price', '1 Hr %', '24 Hr %', '7 Day %'], :rows => row1
		
		
		row2 = []
		row2 << [ market_cap, daily_vol, available_supply, max_supply, "#{available_percent} %"]
		table2 = Terminal::Table.new :title => "#{c['name']} Market Information", :headings => ['Market Cap', '24 Hr Volume', 'Avaiable Supply', 'Total Supply', 'Available %'], :rows => row2

		puts table1
		puts table2
	end

	def currency_format(number)
		number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse.insert(0, "$")
	end

	def goodbye
		puts "Thank you for using Crypto Quote!"
	end
end