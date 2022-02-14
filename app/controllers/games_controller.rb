require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
    @letters
  end

  def score
    @letters = params[:letters].gsub(' ', ' ').chars
    @reponse = params[:suggestion]
    uri = "https://wagon-dictionary.herokuapp.com/#{@reponse}"
    res = URI.open(uri).read
    @json_word = JSON.parse(res)
    if @reponse.chars.all? { |rep| @letters.include?(rep) } == false
      @result = "Sorry but #{@reponse} can't be built out of #{@letters}"
    elsif @json_word['found'] == false
      @result = "Sorry but #{@reponse} does not seem to be a valid English word"
    elsif @json_word['found'] == true
      @result = "Congratulations! #{@reponse} is a valid English word"
    end
  end
end
