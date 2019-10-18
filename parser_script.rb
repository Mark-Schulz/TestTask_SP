# frozen_string_literal: true

require_relative '../services/ser'
require_relative '../services/ple_converter'
require_relative '../services/unique_converter'
require_relative '../services/format_transducer'

content = Parser.new
content.file_reader(ARGV[0])
content.info_parser
statistics1 = SimpleConverter.new(content.information)
statistics1.convert
statistics2 = UniqueConverter.new(content.information)
statistics2.convert
results_for_all_statistics = FormatTransducer.new(statistics1.all_statistics)
results_for_unique_statistics = FormatTransducer.new(statistics2.unique_statistics)

puts 'All visits statistic ( host --- number of visits ):'
results_for_all_statistics.show_formatted_statistics
puts "\nUnique visits statistic ( host --- number of unique visits ):"
results_for_unique_statistics.show_formatted_statistics
