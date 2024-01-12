require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @letters = params[:letters]
    @word = params[:word].downcase if params[:word].present?

    if @word.present?
      if valid_word?(@word, @letters) && english_word?(@word)
      elsif valid_word?(@word, @letters)
        # Le mot est valide selon la grille mais pas un mot anglais
      else
        # Le mot n'est pas valide selon la grille
      end
    else
      # Gérer le cas où aucun mot n'est soumis
    end
  end

  def valid_word?(word, letters)
    letters = letters.dup
    word.chars.all? do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
        true
      else
        false
      end
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.parse(url).open.read
    json_response = JSON.parse(response)
    json_response['found']
  end
end
