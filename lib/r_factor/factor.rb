module RFactor
  module Factor
    def self.get_factors(n)
      factors = []
      while n >= 2
        new_factor = get_smallest_factor(n)
        n /= new_factor
        factors << new_factor
      end
      factors
    end

    private

    def self.get_smallest_factor(n)
      return 2 if n.even?
      3.step(Math.sqrt(n).floor, 2) do |candidate|
        return candidate if n % candidate == 0
      end
      n
    end
  end
end
