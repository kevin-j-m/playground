# TODO: needs to handle there not being a comparison
# TODO: needs to handle there not being a base

module SimpleCov
  module Compare
    class LinesCoverageDifference
      def initialize(base:, comparison:)
        @base = base
        @comparison = comparison
      end

      def filename
        @base.filename
      end

      def base_covered_percent
        @base.covered_percent
      end

      def comparison_covered_percent
        @comparison.covered_percent
      end

      def covered_percent_difference
        comparison_covered_percent - base_covered_percent
      end
    end
  end
end
