ActiveAdmin.register AuthorityContact do
  permit_params :description, :display_name, :phone, :email
end
