require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative "config/environment"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :console do
	def reload!
		load './lib/crypto_quote.rb'
		load './lib/ticker.rb'
		load './lib/crypto_quote/cli.rb'
	end
	Pry.start
end
