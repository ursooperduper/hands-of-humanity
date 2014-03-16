require 'sinatra'
require 'haml'
require 'pg'
require 'sequel'

DB = Sequel.connect(ENV["DATABASE_URL"])

class Card < Sequel::Model(:cards)
  # Cleans us my formatting shortcuts
  def cleanUp
    cardtext.gsub!(/\[\]/, '_______________')
    cardtext.gsub!(/\[b\]/, '<br/>')
    cardtext.gsub!(/\[r\]/, '&reg;')
    cardtext.gsub!(/\[tm\]/, '&trade;')
    cardtext.gsub!(/\[i\]/, '<em>')
    cardtext.gsub!(/\[ii\]/, '</em>')
    return self
  end
end




get '/' do	
  @title = "Hands of Humanity"

  cards = DB.from(:cards)

  # Grab the black and white cards  
  b_cards = cards.where(:color => 'b')
  w_cards = cards.where(:color => 'w')

  b_card_list = b_cards.map(:id).shuffle!
  w_card_list = w_cards.map(:id).shuffle!

  @b_card = Card[b_card_list[0]].cleanUp

  @wh_playcards = []
  i = 0
  while i < @b_card.pick
    @wh_playcards.push(w_card_list[i])
    i += 1
  end

  haml :random
end