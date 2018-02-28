class CouterIndex
  class << self
    def couter page, per
      if page.blank?
        return Settings.counter.page_one
      else
        return (page.to_i - Settings.counter.rm_page) * per + Settings.counter.add_page
      end
    end
  end
end
