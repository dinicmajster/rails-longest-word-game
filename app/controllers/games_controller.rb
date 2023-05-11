require "open-uri"
require "json"
require "nokogiri"

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @choice = params[:word]
    @game_words = params[:game_words]
    if (@choice.chars - @game_words.split(" ")).empty?
      if english_word?(@choice)
        @message = "well done"
      else
        @message = "not an english word"
      end
    else
      @message = "not in the grid"
    end
  end

  def english_word?(choice)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{choice}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
