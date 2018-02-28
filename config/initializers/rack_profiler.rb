environments = Rails.application.config.rack_mini_profiler_environments
if environments.include? Rails.env
   require "rack-mini-profiler"
   Rack::MiniProfilerRails.initialize! Rails.application
end
