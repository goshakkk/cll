module CLL
  class Value
    class << self
      def value_for_raw(raw)
        case raw
        when Integer then IntegerValue.new(raw)
        when true, false then BoolValue.bool(raw)
        else
          raise ArgumentError, "unknown raw value type"
        end
      end
    end
  end

  class IntegerValue < Value
    attr_reader :val

    def initialize(raw)
      @val = raw.to_i
    end

    def +(other)
      self.class.new(val + other.val)
    end

    def -(other)
      self.class.new(val - other.val)
    end

    def >(other)
      BoolValue.bool(val > other.val)
    end

    def <(other)
      BoolValue.bool(val < other.val)
    end

    def ==(other)
      BoolValue.bool(val == other.val)
    end
  end

  class BoolValue < Value
    class << self
      def bool(bool)
        bool ? TrueValue.instance : FalseValue.instance
      end
    end
  end

  class TrueValue < BoolValue
    include Singleton

    def not
      FalseValue.instance
    end
  end

  class FalseValue < BoolValue
    include Singleton

    def not
      TrueValue.instance
    end
  end
end
