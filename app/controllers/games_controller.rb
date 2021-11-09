require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letter_field = ('a'..'z').to_a.sample(8)
    # Randomize the output of the letters
  end

  def score
    # Récuperer le mot proposé par l'user et le stocker dans une variable
    @input = params[:userinput]
    # Récuperer les lettres proposées par l'app -> Variable
    @letter_field = params[:letters].split
    # Vérifier si l'input user correspond aux lettres proposées par l'app -> Variable
    @included = included?(@input, @letter_field)
    # Véifier si l'input de l'utilisateur est un mot anglais qui existe
    @is_english = english_words?(@input)
  end

  private

  def included?(input, letter_field)
    # Les lettres d'input sont comprises dans letter-field
    input.chars.all? do |letter|
      letter_field.include?(letter) && input.count(letter) <= letter_field.count(letter)
    # Pour chacune des lettres dans ton mot splitter / vérifier que le nombre de lettre dans l'input soit <= au nombre de lettre de letter_field
    # return true
    end
  end

  def english_words?(input)
    data = URI.open("https://wagon-dictionary.herokuapp.com/#{input}").read
    user = JSON.parse(data)
    return user['found']
  end
end
