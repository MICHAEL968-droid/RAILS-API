class UserAutheticator
    class AutheticationError < StandardError; end   
    attr_reader :user 
    def initialize(code)

    end

    def perform 
        raise AutheticationError
    end
end