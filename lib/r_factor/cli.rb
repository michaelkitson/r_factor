module RFactor
  class CLI
    def self.start
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
