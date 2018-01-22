class CryptoQuote::Ticker
	@@data = nil

	def initialize
		get_ticker
	end

	def get_ticker
		data = 'https://api.coinmarketcap.com/v1/ticker/?limit=15'
		uri = URI(data)
		response = Net::HTTP.get(uri)
		@@data = JSON.parse(response)
	end

	def data
		@@data
	end

end