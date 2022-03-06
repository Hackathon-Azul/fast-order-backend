module Storefront::V1
  class TablesController < ApplicationController

    def index
   #   @tables = Table.where(avaliable_table: true).order(:id)
     # @tables = Order.joins(:table).select(:id,:table_number, :avaliable_table, :orders).order(:id)
     @tables = Table.all.order(:id)
    end
  end
end