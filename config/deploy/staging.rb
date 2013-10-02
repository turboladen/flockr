server '192.168.33.10', :app, :web, :db, primary: true

set :ssh_options, {
  forward_agent: true,
}
