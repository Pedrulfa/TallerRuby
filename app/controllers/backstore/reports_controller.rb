module Backstore
  class ReportsController < ApplicationController
    before_action :require_login

    def index
      @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : Date.current.beginning_of_month
      @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : Date.current.end_of_month

      range = @start_date.beginning_of_day..@end_date.end_of_day

      @sales = Sale.where(created_at: range).where(cancelled_at: nil)
      
      @total_revenue = @sales.sum(:total)
      @sales_count = @sales.count
      
      # Group by day for the table/chart (Ruby-based to avoid DB-specific SQL or gems)
      sales_data = @sales.to_a.group_by { |s| s.created_at.to_date }
                            .transform_values { |sales| sales.sum(&:total) }
                            .sort

      @sales_by_day = Kaminari.paginate_array(sales_data).page(params[:page]).per(10)
    end
  end
end
