module Admin::V1::Dashboard
  class SalesRangesForUserController < DashboardController
    def index
      @service = Admin::Dashboard::SalesRangeForUserService.new(min: get_date(:min_date), max: get_date(:max_date), user: params[:user_id])
      @service.call
    end
  end
end