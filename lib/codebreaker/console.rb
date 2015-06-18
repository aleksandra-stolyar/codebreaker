require_relative "game"
require_relative "result"
require_relative "user"
require "pry"

module Codebreaker
  class Console

    def initialize
      @game = Game.new
      @result = Result.new
    end

    def start
      puts "Welcome to Codebreaker game!"
      puts 
      puts "A + indicates an exact match: one of the numbers in the guess"
      puts "is the same as one of the numbers in the secret code"
      puts "and in the same position."
      puts
      puts "A - indicates a number match: one of the numbers in the guess"
      puts "is the same as one of the numbers in the secret code"
      puts "but in a different position."
      puts
      puts "To start game print 'start'. If you want to get a hint - print 'hint', to exit the game - 'exit'."
      play if gets.chomp == 'start' || 's'
    end
    
    def play  
      (1..@game.max_attempts).each do  
        puts "Print something or enter your code:"
        input = gets.chomp
        begin
          if input == 'hint'
            puts @game.hint
          elsif input == 'exit'
            exit
          elsif input == 'c'
             puts "#{@game.secret_code}" 
          elsif input[/^[1-6]{4}/]
            @game.check(input)
            puts @game.result
            afterparty if @game.game_status != ''
          elsif input.length < 4
            raise ArgumentError
          elsif !input[/^[1-6]{4}/]
            raise TypeError
          end
        rescue ArgumentError => error
          puts "Secret code must contain 4 numbers, not #{input.length}!"
        rescue TypeError => error
          puts "You have to use only numbers in range 1-6 to break the code."
        end
      end
    end

    def afterparty
      if @game.game_status == 'win'
        puts "You win"
        puts "Do you want to save your score? If yes - print 'yes', if no - 'no'."
        decision = gets.chomp
        begin
          if decision == 'yes'
            puts "Please, enter your name:"; name = gets.chomp
            puts "#{name}, you guessed secret code in #{@game.attempt} attempts!"
            @result.load_results; @result.save_results(User.new(name: name, attempt: @game.attempt))
            restart
          elsif decision == 'no'
            restart
          else
            raise TypeError
          end
        rescue TypeError => error
          puts "Unknown command. Do you want to save your score?"
        end
      else
        puts "You've lost"
        restart
      end
    end

    def restart
      puts "Do you want to play again?"
      restart = gets.chomp
      if restart == 'yes'
        puts "Welcome to new game!"
        Console.new.play
      elsif restart == 'no'
        exit
      end
    end

    Console.new.start
  end
end
