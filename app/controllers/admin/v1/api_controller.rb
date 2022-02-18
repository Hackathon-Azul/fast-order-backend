# frozen_string_literal: true

module Admin::V1
  class ApiController < ApplicationController
    include Authenticatable
  end
end
