module Admin::Dashboard
  class SalesRangeForUserService
    attr_reader :records

    def initialize(min: nil, max: nil, user: nil)
      @min_date = min.present? ? min.beginning_of_day : nil
      @max_date = max.present? ? max.end_of_day : nil
      @user_id = user.present? ? user : 1
      @records = {}
    end

    def call
      if @max_date.present? && @min_date.present? && @max_date - @min_date < 1.month
        @records = group_sales_by_day
      else
        @records = group_sales_by_month
      end
    end

    private

    def group_sales_by_day
      order_filter
        .group("year, month, day")
        .order("year, month, day")
        .pluck(order_arel[:year], order_arel[:month], order_arel[:day], line_item_arel[:total_sold], line_item_arel[:amount_of_sales])
        .map { |record| { date: format_date(*record[0..2]), total_sold: record[3].to_f, amount_of_sales: record[4].to_f  } }
    end

    def group_sales_by_month
      order_filter
        .group("year, month")
        .order("year, month")
        .pluck(order_arel[:year], order_arel[:month], line_item_arel[:total_sold], line_item_arel[:amount_of_sales])
        .map { |record| { date: format_date(*record[0..1]), total_sold: record[2].to_f, amount_of_sales: record[3].to_f } }
    end

    def order_filter
      Order.joins(:order_items)
           .where(status: :Finished, created_at: @min_date..@max_date, user_id: @user_id)
    end

    def format_date(year, month, day = nil)
      year = "%04d" % year
      month = ("-" + "%02d" % month)
      day = ("-" + "%02d" % day) if day.present?
      year + month + day.to_s
    end

    def line_item_arel
      @line_item_arel if @line_item_arel.present?
      arel = Order.arel_table
      total_sold = (arel[:total]).sum.as('total_sold')
      amount_of_sales = (arel[:id]).count.as('amount_of_sales')
      @line_item_arel = { total_sold: total_sold, amount_of_sales: amount_of_sales }
    end

    def order_arel
      @order_arel if @order_arel.present?
      field = Order.arel_table[:created_at]
      @order_arel = { month: field.extract('month').as('month'), year: field.extract('year').as('year'), 
                      day: field.extract('day').as('day') }
    end
  end
end