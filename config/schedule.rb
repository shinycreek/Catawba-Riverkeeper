set :output, "log/cron_log.log"

every 3.hours do
    rake "duke_api_service:update_db_from_api"
end
