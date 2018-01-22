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
				puts ticker[input.to_i - 1]["name"]
				binding.pry
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

	def goodbye
		puts "Thank you for using Crypto Quote!"
	end
end