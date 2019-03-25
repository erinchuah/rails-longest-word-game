require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { [*'A'..'Z'].sample }
  end

  def score()
    @score = 0
    @user_word = params[:user_word].upcase.split('')
    @computer_grid = params[:letters].upcase.split(' ')
    raise

    #check whether all letters were in provided list
    check_letters = @user_word.all? { |letter| @user_word.count(letter) <= @computer_grid.count(letter) }

    #check whether it's a real english word
    url = "https://wagon-dictionary.herokuapp.com/#{@user_word.join}"
    dictionary_serialized = open(url).read
    dictionary_hash = JSON.parse(dictionary_serialized)

    #generate score
    if check_letters == false
      @results = "Sorry but #{@user_word.join('')} can't be built out of #{@computer_grid.join(", ")}"
    elsif dictionary_hash["found"] == false
      @results = "Sorry but #{@user_word.join('')} does not seem to be a valid English word"
    else
      @results = "Congratulations! #{@user_word.join('')} is a valid English word!"
      @score += @user_word.length
    end
  end
end
