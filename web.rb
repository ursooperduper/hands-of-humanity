require 'sinatra'
require 'haml'
require 'sequel'


get '/' do
	conn = PG::Connection.open(:dbname => 'cards')
	b_cards = conn.exec('SELECT id FROM cards WHERE color = \'w\'')
	w_cards = conn.exec('SELECT id FROM cards WHERE color = \'b\'')
	
  

  @title = "FUH"



  haml :random
end