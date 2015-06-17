require 'yaml'
require_relative "user"

module Codebreaker
  class Result < User

    RESULTS_DATA = "results_data.yml"
    attr_accessor :user_result

    def initialize
      @user_result = []
    end
    
    def save_results(user)
      @user_result.push(user)
      return "No such file" unless File.exist?(RESULTS_DATA)
      File.open(RESULTS_DATA, "w") do |f|
        f.write YAML.dump(@user_result)
      end
    end

    def load_results
      return "No such file" unless File.exist?(RESULTS_DATA)
      file = YAML::load(File.read(RESULTS_DATA))
      file.each do |o|
        o = User.new(name: o.name, attempt: o.attempt)
        @user_result.push(o)
      end
    end

  end
end