require 'yaml'

module Codebreaker
  class Result

    RESULTS_DATA = "./results_data.yml"
    attr_accessor :results

    def initialize
      @results = YAML::load(File.read(RESULTS_DATA)) || []

      rescue Exception => e
        puts "No such file to save data" 
        @results = []
    end
    
    def save!
      File.open(RESULTS_DATA, "w") do |f|
        f.write YAML.dump(@results)
      end
    end

    def add(user_name, attempts)
      @results << {
        name: user_name,
        attempts: attempts
      }
    end

  end
end