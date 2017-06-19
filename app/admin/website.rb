ActiveAdmin.register Website do

  permit_params :url, :website_type
  filter :url
  filter :website_type

  show do 
    attributes_table do
      row :url
      row :website_type
    end
  end

  form  do |f|
    f.inputs do
      f.input :url
      f.input :website_type, as: :select, collection: Website.website_types.keys, :include_blank => false
    end
    f.actions do
      f.action(:submit, label: f.object.new_record? ? "Create Website" : "Update Website")
      f.cancel_link
    end
  end

end