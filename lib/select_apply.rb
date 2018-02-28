class SelectApply
  class << self
    def caclulate_applies total, size_applies
      return Settings.dashboard.zero if size_applies == Settings.dashboard.zero
      (size_applies.to_f / total * Settings.percent).round Settings.rounding
    end

    def caclulate_applies_step company
      hashes = {}
      steps_company = company.steps
      steps_company.each do |step|
        hashes[step.name] = Settings.default_value
      end
      apply_steps = company.apply_statuses.current.includes(:step).group_by &:step
      apply_steps.each do |apply_step|
        if hashes.keys.include? apply_step.first.name
          hashes[apply_step.first.name] = apply_step.second.size
        end
      end
      hashes
    end

    def math_col_grid size
      return Settings.grid.width_6 if size.zero?
      Settings.grid.width_12 / size
    end
  end
end
