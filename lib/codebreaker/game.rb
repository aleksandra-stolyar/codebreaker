require "pry"
require "yaml"
module Codebreaker
  class Game
    attr_reader :secret_code
    attr_accessor :attempt, :max_attempts, :has_hint, :user, :user_results, :game_status

    MAX_ATTEMPTS = 10

    def initialize
      @secret_code = 4.times.map {rand(1..6)}
      @attempt = 0
      @max_attempts = Game::MAX_ATTEMPTS
      @has_hint = true
      @game_status = ''
    end

    def check(user_code)
      result = ''
      @attempt += 1
      secret_code_copy = secret_code.dup
      user_code = user_code.split("").map { |s| s.to_i }
      user_code_copy = user_code.dup

      user_code.each_with_index do |uci, uii| #uci - user code item, uii - user item index
        if uci == secret_code[uii] 
          result << '+' 
          secret_code_copy.slice!(secret_code_copy.index(uci))
          user_code_copy.slice!(uci)
        end
      end

      user_code_copy.each do |item|
        if secret_code_copy.include?(item)
          result << '-'
          secret_code_copy.slice!(secret_code_copy.index(item))
        end
      end
      result = result.chars.sort.join
      puts "#{result}"

      if result == '++++' && @attempt <= @max_attempts
        @game_status = 'win'
      elsif result != '++++' && @attempt == @max_attempts
        @game_status = 'loose'
      end

    end

    def hint
      if @has_hint
        secret_code_copy = secret_code.dup

        hint = []
        index = Random.rand(0..3)
        secret_code.each_with_index do |n, i|
          if i == index
            hint << n
          else
            hint << '*'
          end
        end
        @has_hint = false
      else
        puts "Your hint is already used"
      end

      puts "#{hint.join}"
    end

  end
end
