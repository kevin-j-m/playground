# TODO: a top-level module that takes in two file paths
# creates two result sets
# Iterates through the base files
# Finds the comparison file name - deletes from collection of comparison files
# Calculates coverage difference
# Iterates through remaining comparison files
# Calculates coverage difference
# Given a formatter, formats the output of the collection of differences
# The collection of differences should probably be a class this creates that's
# essentially a facade over an array.

module SimpleCov
  module Compare
    class ResultSet
      def initialize(file_path)
        @file_path = file_path
      end

      def files
        # Build a wrapper around source file to only have what we need? A way to
        # compare the differences?
        # Maybe a file set that we can remove items from?
        result.files # SimpleCov::SourceFile
        # result.files.first.covered_percent
      end

      # TODO: private?

      def result
        return @result if defined?(@result)

        resultset_json = parse_file
        command_plus_coverage = resultset_json
          .map { |command_name, data| [[command_name], data.fetch("coverage")] }
          .first

        @result = SimpleCov::Result.new(command_plus_coverage.last, command_name: command_plus_coverage.first)
      end

      private

      def parse_file
        data = read_file
        parse_json(data)
      end

      def read_file
        return unless File.exist?(@file_path)

        data = File.read(@file_path)
        return if data.nil? || data.length < 2

        data
      end

      def parse_json(content)
        return {} unless content

        JSON.parse(content) || {}
      rescue StandardError
        # warn "[SimpleCov]: Warning! Parsing JSON content of resultset file failed"
        {}
      end
    end
  end
end

# require "#{Rails.root}/lib/simplecov-compare/result_set"
# require "simplecov"
# rs = SimpleCov::Compare::ResultSet.new(SimpleCov::ResultMerger::resultset_path)
# result = rs.result
