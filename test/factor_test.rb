require_relative 'test_helper'

module RFactor
  class FactorTest < Minitest::Test
    def test_version_number_presence
      refute_nil ::RFactor::VERSION
    end

    def test_factoring_1_to_20
      assert_equal [], Factor.get_factors(1)
      assert_equal [2], Factor.get_factors(2)
      assert_equal [3], Factor.get_factors(3)
      assert_equal [2, 2], Factor.get_factors(4)
      assert_equal [5], Factor.get_factors(5)
      assert_equal [2, 3], Factor.get_factors(6)
      assert_equal [7], Factor.get_factors(7)
      assert_equal [2, 2, 2], Factor.get_factors(8)
      assert_equal [3, 3], Factor.get_factors(9)
      assert_equal [2, 5], Factor.get_factors(10)
      assert_equal [11], Factor.get_factors(11)
      assert_equal [2, 2, 3], Factor.get_factors(12)
      assert_equal [13], Factor.get_factors(13)
      assert_equal [2, 7], Factor.get_factors(14)
      assert_equal [3, 5], Factor.get_factors(15)
      assert_equal [2, 2, 2, 2], Factor.get_factors(16)
      assert_equal [17], Factor.get_factors(17)
      assert_equal [2, 3, 3], Factor.get_factors(18)
      assert_equal [19], Factor.get_factors(19)
      assert_equal [2, 2, 5], Factor.get_factors(20)
    end

    def test_factoring_large_numbers
      assert_equal [150045023], Factor.get_factors(150045023)
      assert_equal [150045029], Factor.get_factors(150045029)
      assert_equal [150045023, 150045029], Factor.get_factors(150045023*150045029)
    end

    def test_with_many_factors
      assert_equal Array.new(65) { 2 }, Factor.get_factors(2**65)
    end

    def test_with_random_numbers
      10000.times do
        n = Random.rand(2**32)
        assert_equal n, Factor.get_factors(n).reduce(1, :*)
      end
    end

    def test_too_small
      assert_equal [], Factor.get_factors(0)
      assert_equal [], Factor.get_factors(-1)
      assert_equal [], Factor.get_factors(-2)
    end
  end
end
