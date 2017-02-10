require 'rails_helper'

RSpec.describe Payslip, type: :model do
  it "has valid name" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, first_name: "David")
    allow(payslip).to receive_message_chain(:employee, last_name: "Rudd")

    expect(payslip.name).to eq("David Rudd")
  end

  it "has correct gross_income when cents >= 50" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 24)

    expect(payslip.gross_income).to eq(2)
  end

  it "has correct gross_income when cents < 50" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 13)

    expect(payslip.gross_income).to eq(1)
  end

  it "has correct income tax when annual salary between 0 and 18200" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 10000)

    expect(payslip.income_tax).to eq(833)
  end

  it "has correct income tax when annual salary between 18201 and 37000" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 21877)

    expect(payslip.income_tax).to eq(58)
  end

  it "has correct income tax when annual salary between 37001 and 80000" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 60050)

    expect(payslip.income_tax).to eq(922)
  end

  it "has correct income tax when annual salary between 80001 and 180000" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 100000)

    expect(payslip.income_tax).to eq(2079)
  end

  it "has correct income tax when annual salary more than 180000" do
    payslip = Payslip.new
    allow(payslip).to receive_message_chain(:employee, annual_salary: 180001)

    expect(payslip.income_tax).to eq(4546)
  end

  it "has correct net income" do
    payslip = Payslip.new
    allow(payslip).to receive_messages(gross_income: 5004, income_tax: 922)

    expect(payslip.net_income).to eq(4082)
  end

  it "has correct super" do
    payslip = Payslip.new
    allow(payslip).to receive_messages(gross_income: 5004)
    allow(payslip).to receive_message_chain(:employee, super_rate: 9)

    expect(payslip.super).to eq(450)
  end

end

