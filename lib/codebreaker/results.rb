require 'yaml'
module Codebreaker
  class Result

    RESULTS_DATA = "results_data.yml"

    class << self
      # def user_result(user = {})
      #   user = {}
      #   "User: #{user[:name]}, number of attempts: #{user[:attempt]}, hint used: #{user[:hint]}"
      # end

      #write data
      def write_results(data)
        File.open('results_data.yml', 'w') do |f|
          f.write YAML.dump(data)
        end
      end

      #read data
      def read_results
        YAML.load(File.open('results_data.yml')
      end

      def save_results(name, attempt, hint)
        user_result = {name: name, attempt: attempt, hint: hint}
        self.write_results(user_result)
      end

      





    end

  end
end