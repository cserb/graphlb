require "./token.cr"
module Dot
  module AST
    class BlockToken < ValueToken
      getter :id, :values, :blocks

      alias Value = NamedTuple(
        id: String,
        values: Hash(String, ValueType),
        blocks: Array(Value)
      )

      def initialize(
        peg_tuple : Pegmatite::Token,
        string : String,
        id : String,
        args : Array(StringToken),
        values : Hash(String, ValueToken),
        blocks : Array(BlockToken)
      )
        super(peg_tuple, string)

        @id = id
        @args = args
        @values = values
        @blocks = blocks
      end

      def value : ValueType
        {
          id: id,
          args: args.map { |arg| arg.value },
          values: values_dict,
          blocks: blocks.map { |block| block.value.as(Value) }
        }
      end

      private def values_dict
        dict = {} of String => ValueType

        values.each do |key, value|
          dict[key] = value.value.as(ValueType)
        end

        dict
      end
    end
  end
end
