module Codebreaker
  class User
    attr_accessor :name, :attempt

    def initialize(args)
      @name = args[:name]
      @attempt = args[:attempt]
    end

  end
end
