# Make sure we run in the context of bundler.
gemfile = File.expand_path(File.join(__FILE__, '..', 'Gemfile'))

if File.exist?(gemfile) && ENV['BUNDLE_GEMFILE'].nil?
  puts "Respawning with 'bundle exec'"
  exec('bundle', 'exec', 'cap', *ARGV)
end

# Load capistrano-related files.
load 'deploy'
load 'deploy/assets'
load 'config/deploy' # remove this line to skip loading any of the default tasks
