require_relative 'test_helper'

class CLITest < Minitest::Test
  def with_captured_stdout
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  def test_one_argument
    ARGV.replace %w(24)
    output = with_captured_stdout do
      RFactor::CLI.start
    end
    assert_equal "24: 2 2 2 3\n", output
  end

  def test_multiple_arguments
    ARGV.replace %w(24 45)
    output = with_captured_stdout do
      RFactor::CLI.start
    end
    assert_equal "24: 2 2 2 3\n45: 3 3 5\n", output
  end

  def test_bad_argument
    ARGV.replace %w(bad)
    output = with_captured_stdout do
      RFactor::CLI.start
    end
    assert_equal "factor: 'bad' is not a valid positive integer\n", output
  end
end
