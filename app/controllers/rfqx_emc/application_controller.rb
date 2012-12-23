module RfqxEmc
  class ApplicationController < ActionController::Base
    helper Authentify::SessionsHelper
    helper Authentify::UserPrivilegeHelper
    helper Authentify::AuthentifyUtility
    include Authentify::SessionsHelper
    include Authentify::UserPrivilegeHelper
    include Authentify::AuthentifyUtility
  end
end
