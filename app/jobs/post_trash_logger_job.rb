class PostTrashLoggerJob < ApplicationJob

  def perform(trash_logger_id)
    logger.info "Starting PostTrashLogJob.perform"
    trash_logger = TrashLogger.find(trash_logger_id)
    if trash_logger.present?
      json = generate_json(trash_logger)
      object_id = send_create_post(json)
      trash_logger.upload_images.each do |img|
        image_path=img.image.url
        send_image_post(object_id, image_path)
      end
    end
    logger.info "PostTrashLogJob.perform complete"
  end

  private

  def generate_json(trash_logger)
    user=trash_logger.user_setting

    json_in= [
    {
      "geometry":{
        "x": trash_logger.longitude,
        "y": trash_logger.latitude,
        "spatialReference": {
          "wkid":4326
        }
      },
      "attributes":{
        "TrashDescription": trash_logger.describe_trash,
        "TrashLocationExtent": trash_logger.describe_location,
        "TrashCounty": trash_logger.county,
        "Waterway": trash_logger.adjacent_waterway,
        "LoggerEmail": user.try(:email),
        "LoggerPhone": user.try(:phone),
        "Status": "Unreviewed",
        "CRFNotes": nil,
        "LoggerName": "#{user.try(:first_name)} #{user.try(:last_name)}"
      }
    }
  ]
  end

  # takes in pollution report json
  # returns object id to use for images
  def send_create_post(json)
    uri = URI.parse("https://services6.arcgis.com/QKzAuFxgK44hIfg6/ArcGIS/rest/services/Trash_Logger/FeatureServer/0/applyEdits")
    res=Net::HTTP.post_form(uri, 'f' => 'json', 'adds' => json.to_json)

    raise "Error: Failed POST to arcgis for trash logger: #{res.body}" if !res.is_a?(Net::HTTPSuccess)
    # finds the object id from the return from arcgis
    res_json=JSON.parse(res.body)
    Rails.logger.debug "arcgis CREATE POST for trash logger successful"
    id=res_json["addResults"][0]["objectId"]
  end

  def send_image_post(object_id, image_path)
    uri = URI.parse("https://services6.arcgis.com/QKzAuFxgK44hIfg6/ArcGIS/rest/services/Trash_Logger/FeatureServer/0/#{object_id}/addAttachment")
    conn = Faraday.new(:url => uri ) do |faraday|
      faraday.request :multipart
      #faraday.response :logger, Logger.new(STDOUT), bodies: true
      faraday.adapter :net_http
    end
    image_path[0]=''
    image_path=Rails.public_path.join(image_path)
    payload = { :attachment => Faraday::UploadIO.new(image_path.to_s, 'image/jpeg') , :f => "json"}
    res=conn.post uri, payload
    raise "Error: Failed to add image to arcgis for trash logger: #{res.body}" if res.status!=200
    Rails.logger.debug "arcgis ADD IMAGE POST for trash logger successful"
  end
end
