Dir[File.join(File.dirname(__FILE__), 'mongodb/*.rb')].sort.each { |lib| require lib }
