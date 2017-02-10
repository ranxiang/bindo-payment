class PayslipsController < ApplicationController
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.valid?
        @payslip = @employee.payslip_by_month(params[:payment_start_date])
      end
      format.html { render :new }
    end
  end

  private

   def employee_params
     params.require(:employee).permit(:first_name, :last_name, :annual_salary, :super_rate)
   end

end
