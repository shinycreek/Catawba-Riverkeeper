class PostPollutionReportJob < ApplicationJob
  queue_as :default

  def perform(pollution_report_id)
    logger.info "Starting PostPollutionReportJob.perform"
    pollution_report = PollutionReport.find(pollution_report_id)
    if pollution_report.present?
      json = generate_json(pollution_report)
      object_id = send_create_post(json)
      pollution_report.upload_images.each do |img|
        image_path=img.image.url
        send_image_post(object_id, image_path)
      end
    end
    logger.info "PostPollutionReportJob.perform complete"
  end

  private

  def generate_json(pollution_report)
    user=UserSetting.where(phone_id: pollution_report.phone_id).first

    json_in= [
    {
      "geometry":{
        "x": pollution_report.longitude,
        "y": pollution_report.latitude,
        "spatialReference":{
          "wkid":4326
        }
      },
      "attributes":{
        "OtherInfo": "other information",
        "PollutionAddress": "Pollution address",
        "PublicView": "No",
        "ReporterName": "#{user.try(:first_name)} #{user.try(:last_name)}",
        "ReporterEmail": user.try(:email),
        "ReporterPhone": user.try(:phone),
        "ReporterAddress": user.try(:address),
        "PollutionCounty": pollution_report.county,
        "MDYDate": (pollution_report.created_at.to_i)*1000,
        "PollutionDuration": pollution_report.pollution_duration,
        "PollutionWaterway": pollution_report.waterway_affected,
        "PollutionDescription": pollution_report.describe_pollution,
        "PollutionResponsible": "TBD party responsible",
        "CRFStatus": "Unreviewed",
        "CRFNotes": nil
      }
    }
  ]
  end

  # takes in pollution report json
  # returns object id to use for images
  def send_create_post(json)
    uri = URI.parse("https://services6.arcgis.com/QKzAuFxgK44hIfg6/arcgis/rest/services/Pollution_Reporter/FeatureServer/0/applyEdits")
    res=Net::HTTP.post_form(uri, 'f' => 'json', 'adds' => json.to_json)

    raise "Error: Failed POST to arcgis for pollution report: #{res.body}" if !res.is_a?(Net::HTTPSuccess)
    # finds the object id from the return from arcgis
    res_json=JSON.parse(res.body)
    Rails.logger.debug "arcgis CREATE POST successful"
    id=res_json["addResults"][0]["objectId"]
  end

  def send_image_post(object_id, image_path)
    uri = URI.parse("https://services6.arcgis.com/QKzAuFxgK44hIfg6/arcgis/rest/services/Pollution_Reporter/FeatureServer/0/#{object_id}/addAttachment")
    conn = Faraday.new(:url => uri ) do |faraday|
      faraday.request :multipart
      #faraday.response :logger, Logger.new(STDOUT), bodies: true
      faraday.adapter :net_http
    end
    image_path[0]=''
    image_path=Rails.public_path.join(image_path)
    payload = { :attachment => Faraday::UploadIO.new(image_path.to_s, 'image/jpeg') , :f => "json"}
    res=conn.post uri, payload
    raise "Error: Failed to add image to arcgis for pollution report: #{res.body}" if res.status!=200
    Rails.logger.debug "arcgis ADD IMAGE POST successful"
  end
end
