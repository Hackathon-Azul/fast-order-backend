module Storefront::V1
  class TablesController < ApplicationController

    def index
      @tables = Table.where(avaliable_table: true).order(:id)
    end
  end
end