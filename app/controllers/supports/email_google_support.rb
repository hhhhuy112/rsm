module Supports
  class EmailGoogleSupport
    def initialize page, start_index, end_index, email_googles, size
      @page = page
      @start_index = start_index
      @end_index = end_index
      @email_googles = email_googles
      @size = size
    end

    def get_data
      {
        page: @page,
        start_index: @start_index,
        end_index: @end_index,
        email_googles: @email_googles,
        size: @size
      }
    end
  end
end
