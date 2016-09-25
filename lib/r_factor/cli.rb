module RFactor
  class CLI
    def self.start
      ARGV.each do |arg|
        number = arg.to_i
        unless number.to_s == arg
          puts "factor: '#{arg.gsub('\\'){'\\\\'}.gsub("'"){"\\'"}}' is not a valid positive integer"
          next
        end

        factors = RFactor.factor(number)
        puts "#{number}: #{factors.join(' ')}"
      end
    end
  end
end
