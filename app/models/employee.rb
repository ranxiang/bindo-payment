class Employee
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :annual_salary, :super_rate

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :annual_salary, presence: true, numericality: { only_integer: true }
  validates :super_rate, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 100 }

  def payslip_by_month(payment_start_date)
    Payslip.new({employee: self, payment_start_date: payment_start_date })
  end

  def annual_salary
    @annual_salary.to_i
  end

  def super_rate
    @super_rate.to_i
  end
end
