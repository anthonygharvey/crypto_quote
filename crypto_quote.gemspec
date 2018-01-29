
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "crypto_quote/version"

Gem::Specification.new do |spec|
  spec.name          = "crypto_quote"
  spec.version       = CryptoQuote::VERSION
  spec.authors       = ["Anthony"]
  spec.email         = ["anthony@anthonygharvey.com"]

  spec.summary       = "A gem to display quote information for popular cryptocurrencies"
  spec.description   = "This gem will display quote information for the top 15 crytocurrencies"
  spec.homepage      = "https://anthonygharvey.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "json"
  spec.add_development_dependency "terminal-table"
  spec.add_development_dependency "colorize"
end
