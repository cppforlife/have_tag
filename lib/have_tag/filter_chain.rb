module HaveTag
  class FilterChain
    def initialize(fail_fast)
      @fail_fast = fail_fast
      yield @filters = []
    end

    def filter(fragments)
      @filters.each do |@last_filter|
        fragments = @last_filter.filter(fragments)
        break if @fail_fast && @last_filter.failed?
      end

      if @last_filter.failed?
        [nil, @last_filter.failure]
      else
        [fragments, nil]
      end
    end
  end
end