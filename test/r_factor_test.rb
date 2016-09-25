require_relative 'test_helper'

class RFactorTest < Minitest::Test
  def test_version_number_presence
    refute_nil ::RFactor::VERSION
  end

  def test_factoring_1_to_20
    assert_equal [], RFactor.factor(1)
    assert_equal [2], RFactor.factor(2)
    assert_equal [3], RFactor.factor(3)
    assert_equal [2, 2], RFactor.factor(4)
    assert_equal [5], RFactor.factor(5)
    assert_equal [2, 3], RFactor.factor(6)
    assert_equal [7], RFactor.factor(7)
    assert_equal [2, 2, 2], RFactor.factor(8)
    assert_equal [3, 3], RFactor.factor(9)
    assert_equal [2, 5], RFactor.factor(10)
    assert_equal [11], RFactor.factor(11)
    assert_equal [2, 2, 3], RFactor.factor(12)
    assert_equal [13], RFactor.factor(13)
    assert_equal [2, 7], RFactor.factor(14)
    assert_equal [3, 5], RFactor.factor(15)
    assert_equal [2, 2, 2, 2], RFactor.factor(16)
    assert_equal [17], RFactor.factor(17)
    assert_equal [2, 3, 3], RFactor.factor(18)
    assert_equal [19], RFactor.factor(19)
    assert_equal [2, 2, 5], RFactor.factor(20)
  end

  def test_factoring_large_numbers
    assert_equal [150045023], RFactor.factor(150045023)
    assert_equal [150045029], RFactor.factor(150045029)
    assert_equal [150045023, 150045029], RFactor.factor(150045023*150045029)
  end

  def test_with_many_factors
    assert_equal Array.new(65) {2}, RFactor.factor(2**65)
  end

  def test_with_random_numbers
    10000.times do
      n = Random.rand(2**32)
      assert_equal n, RFactor.factor(n).reduce(1, :*)
    end
  end

  def test_too_small
    assert_equal [], RFactor.factor(0)
    assert_equal [], RFactor.factor(-1)
    assert_equal [], RFactor.factor(-2)
  end
end
