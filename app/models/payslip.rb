class Payslip
  include ActiveModel::Model
  attr_accessor :employee, :payment_start_date

  validates :employee, presence: true
  validates :payment_start_date, presence: true

  NUM_MONTHS_OF_YEAR = 12

  def name
    "#{employee.first_name} #{employee.last_name}"
  end

  def pay_period
    # we can adjust the style of date here if need
    payment_start_date
  end

  def gross_income
    (employee.annual_salary / NUM_MONTHS_OF_YEAR.to_f).round
  end

  def income_tax
    tax_plus_factor, tax_multiply_factor, tax_minus_factor = if employee.annual_salary <= 18200
                                                               [0, 1, 0]
                                                             elsif employee.annual_salary <= 37000
                                                               [0, 0.19, 18200]
                                                             elsif employee.annual_salary <= 80000
                                                               [3572, 0.325, 37000]
                                                             elsif employee.annual_salary <= 180000
                                                               [17547, 0.37, 80000]
                                                             else
                                                               [54547, 0.45, 180000]
                                                             end
    ((tax_plus_factor + (employee.annual_salary - tax_minus_factor) * tax_multiply_factor) / NUM_MONTHS_OF_YEAR.to_f).round
  end

  def net_income
    gross_income - income_tax
  end

  def super
    # divide 100 because we store super_rate as integer before
    (gross_income * employee.super_rate / 100.0).round
  end
end
