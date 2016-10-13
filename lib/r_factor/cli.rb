require 'optparse'

module RFactor
  class CLI
    def self.start
      OptionParser.new do |opts|
        opts.banner = 'Usage: factor [options] [<integer> ...]'
        opts.version = RFactor::VERSION

        opts.on('-v', '--version', 'Show version number') do
          puts opts.ver
          exit
        end

        opts.on('-h', '--help', 'Show help message') do
          puts opts.help
          exit
        end
      end.parse!

      inputs = ARGV

      if inputs.empty?
        $stdin.each_line do |line|
          inputs.concat(line.split)
        end
      end

      inputs.keep_if do |arg|
        if arg.to_i.to_s == arg
          true
        else
          $stderr.puts "factor: '#{arg.gsub('\\') { '\\\\' }.gsub("'") { "\\'" }}' is not a valid positive integer"
          false
        end
      end

      inputs.each do |arg|
        factors = Factor.get_factors(arg.to_i)
        puts "#{arg}: #{factors.join(' ')}"
      end
    end
  end
end
