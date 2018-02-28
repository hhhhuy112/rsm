class ConvertDate
  class << self
    def format_date received_time
      Date.strptime(received_time, Settings.date_format)
    end

    def check_date received_time
      received_time > Time.now.strftime("%Y-%m-%d").to_date
    end
  end
end
