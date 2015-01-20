class Card

  attr_accessor :value

  def initialize(suit, name)
    @suit = suit
    @name = name
    if name == "A"
      @value = 11
    elsif name == "J" || name == "Q" || name == "K"
      @value = 10
    else
      @value = name
    end

  end

  def to_s
    [@name, @suit].join("-")
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def total
    total = 0
    @cards.each do |card|
      total = total + card.value
    end
    total
  end

  def to_s
    cards.join(" - ")
  end

end

class Deck

  def initialize
    @cards = []

    suits = [:hearts, :diamonds, :spades, :clubs]
    suits.each do |suit|
      (2..10).each do |value|
        @cards << Card.new(suit, value)
      end
      @cards << Card.new(suit, "J")
      @cards << Card.new(suit, "Q")
      @cards << Card.new(suit, "K")
      @cards << Card.new(suit, "A")
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    @cards.shift
  end


end

class Game

  def run

    player_hand = Hand.new
    dealer_hand = Hand.new

    deck = Deck.new
    deck.shuffle

    2.times do
      player_hand.cards << deck.deal
      dealer_hand.cards << deck.deal
    end


    puts "Welcome to Blackjack!"

    player_has_stayed = false

    until player_has_stayed || player_hand.total >= 21
      puts "Here are your cards: #{player_hand}"
      puts "Dealer is showing: XX - #{dealer_hand.cards.last}"
      puts "Would you like to (h)it, or (s)tay?"

      choice = gets.chomp
      if choice == "h"
        player_hand.cards << deck.deal
      else
        player_has_stayed = true
      end

      puts "Here are your cards: #{player_hand}"
      puts "Your total is: #{player_hand.total}"


    end

    if player_hand.total > 21
      puts "Player BUSTS with #{player_hand.total}"
    else

      until dealer_hand.total >= 16
        dealer_hand.cards << deck.deal
      end
      puts "Dealer cards: #{dealer_hand}"
      puts "Dealer value: #{dealer_hand.total}"

    end


  end

end

game = Game.new
game.run
