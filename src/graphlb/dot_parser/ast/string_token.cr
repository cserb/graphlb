module Dot
  module AST
    class StringToken < ValueToken
      def value
        string
      end
    end
  end
end
