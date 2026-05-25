module SavingsAccount
  def self.interest_rate(balance)
    case
    when balance.negative? then -3.213
    when balance < 1000.0 then  0.5
    when balance < 5000.0 then  1.621
    else 2.475
    end
  end

  def self.annual_balance_update(balance)
    balance + balance * interest_rate(balance).abs * 0.01
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years   = 0
    balance = current_balance
    diff    = desired_balance - current_balance

    while desired_balance > balance do
      years += 1
      balance = annual_balance_update(balance)
      raise "Not going to happen!" if desired_balance - balance > diff
    end

    years
  end
end
