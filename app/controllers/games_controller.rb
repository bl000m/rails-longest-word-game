require "open-uri"
require "json"
class GamesController < ApplicationController

  def new
    @letters = ("a".."z").to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    @valid_letters = valid_letters?(@word, @letters)
    @valid_word = valid_word?(@word)

    if @valid_letters && @valid_word
      @result = "ok"
    elsif @valid_letters == false && @valid_word
      @result = "letters not ok, word ok"
    elsif @valid_letters && @valid_word == false
      @result = "letters ok, word not ok"
    else
      @result = "letters not ok, word not ok"
    end
  end

  private

  def valid_letters?(word, letters)
    ok_array = []
    word.split('').each do |letter|
      if letters.split(' ').include?(letter)
        ok_array << "ok"
      else
        ok_array << "not ok"
      end
    end

    ok_array.include?("not ok") ? false : true
  end

  def valid_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    buffer = URI(url).read
    return JSON.parse(buffer)["found"]
  end
end
