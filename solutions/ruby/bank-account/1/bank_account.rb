class BankAccount
  BALANCE_CLOSED_ERROR    = "You can't check the balance of a closed account"
  DEPOSIT_CLOSED_ERROR    = "You can't deposit money into a closed account"
  DEPOSIT_NEGATIVE_ERROR  = "You can't deposit a negative amount"
  WITHDRAW_CLOSED_ERROR   = "You can't withdraw money into a closed account"
  OVERDRAW_ERROR          = "You can't withdraw more than you have"
  WITHDRAW_NEGATIVE_ERROR = "You can't withdraw a negative amount"
  CLOSE_CLOSED_ERROR      = "You can't close an already closed account"
  OPEN_OPENED_ERROR       = "You can't open an already open account"

  def balance
    raise ArgumentError.new BALANCE_CLOSED_ERROR unless @is_open
    @balance
  end

  def open
    raise ArgumentError.new OPEN_OPENED_ERROR if @is_open
    @is_open = true
    @balance = 0
  end

  def close
    raise ArgumentError.new CLOSE_CLOSED_ERROR unless @is_open
    @is_open = false
  end

  def deposit(amount)
    raise ArgumentError.new DEPOSIT_CLOSED_ERROR unless @is_open
    raise ArgumentError.new DEPOSIT_NEGATIVE_ERROR if amount.negative?
    @balance += amount
  end

  def withdraw(amount)
    raise ArgumentError.new WITHDRAW_CLOSED_ERROR unless @is_open
    raise ArgumentError.new OVERDRAW_ERROR if amount > @balance
    raise ArgumentError.new WITHDRAW_NEGATIVE_ERROR if amount.negative?
    @balance -= amount
  end
end
