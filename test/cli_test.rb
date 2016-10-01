require_relative 'test_helper'

module RFactor
  class CLITest < Minitest::Test
    def setup
      ARGV.replace([])
    end

    def test_one_argument
      ARGV.replace %w(24)
      output = with_captured_output do
        CLI.start
      end
      assert_equal "24: 2 2 2 3\n", output[:stdout]
      assert_empty output[:stderr]
    end

    def test_multiple_arguments
      ARGV.replace %w(24 45)
      output = with_captured_output do
        CLI.start
      end
      assert_equal "24: 2 2 2 3\n45: 3 3 5\n", output[:stdout]
      assert_empty output[:stderr]
    end

    def test_bad_argument
      ARGV.replace %w(bad)
      output = with_captured_output do
        CLI.start
      end
      assert_empty output[:stdout]
      assert_equal "factor: 'bad' is not a valid positive integer\n", output[:stderr]
    end

    def test_mixed_arguments
      ARGV.replace %w(9 bad 37)
      output = with_captured_output do
        CLI.start
      end
      assert_equal "9: 3 3\n37: 37\n", output[:stdout]
      assert_equal "factor: 'bad' is not a valid positive integer\n", output[:stderr]
    end

    def test_one_stdin
      output = with_captured_output do
        with_given_stdin '24' do
          CLI.start
        end
      end
      assert_equal "24: 2 2 2 3\n", output[:stdout]
      assert_empty output[:stderr]
    end

    def test_many_on_one_line_stdin
      output = with_captured_output do
        with_given_stdin '24 9 37' do
          CLI.start
        end
      end
      assert_equal "24: 2 2 2 3\n9: 3 3\n37: 37\n", output[:stdout]
      assert_empty output[:stderr]
    end

    def test_many_lines_stdin
      output = with_captured_output do
        with_given_stdin "24\n9 bad\n37" do
          CLI.start
        end
      end
      assert_equal "24: 2 2 2 3\n9: 3 3\n37: 37\n", output[:stdout]
      assert_equal "factor: 'bad' is not a valid positive integer\n", output[:stderr]
    end


    def test_stdin_with_arbitrary_whitespace
      output = with_captured_output do
        with_given_stdin "  24\t12\t4" do
          CLI.start
        end
      end
      assert_equal "24: 2 2 2 3\n12: 2 2 3\n4: 2 2\n", output[:stdout]
      assert_empty output[:stderr]
    end

    private

    def with_captured_output
      begin
        old_stdout = $stdout
        $stdout = StringIO.new('', 'w')
        old_stderr = $stderr
        $stderr = StringIO.new('', 'w')
        yield
        {stdout: $stdout.string, stderr: $stderr.string}
      ensure
        $stdout = old_stdout
        $stderr = old_stderr
      end
    end

    def with_given_stdin(string)
      begin
        old_stdin = $stdin
        $stdin = StringIO.new(string)
        yield
      ensure
        $stdin = old_stdin
      end

    end
  end
end
