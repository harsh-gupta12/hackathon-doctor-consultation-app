# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  include JwtAuth
end
