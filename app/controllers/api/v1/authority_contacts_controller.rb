class Api::V1::AuthorityContactsController < ApplicationController

  def index
    @authority_contacts = AuthorityContact.all
  end

end
