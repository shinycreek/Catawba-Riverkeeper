Rails.application.config.after_initialize do
  if defined?(Rails::Server)
    DukeAPIJob.perform_now
  end
end
