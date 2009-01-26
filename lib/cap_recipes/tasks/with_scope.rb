# role = :app
def with_role(role, &block)
  original, ENV['HOSTS'] = ENV['HOSTS'], find_servers(:roles => role).map{|d| d.host}.join(",")
  begin
    yield
  ensure
    ENV['HOSTS'] = original
  end
end

# options = { :user => 'xxxxx', :password => 'xxxxx' }
def with_credentials(options={}, &block)
  original_username, original_password = user, password
  begin
    set :user,     options[:user] || original_username
    set :password, options[:password] || original_password
    yield
  ensure
    set :user,     original_username
    set :password, original_password
  end
end