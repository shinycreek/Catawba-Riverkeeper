Rails.application.config.after_initialize do
  DukeAPIJob.perform_now
end
