local BankAccount = {}

local closed_account_error  = 'The account is closed.'
local negative_amount_error = 'Amount must be greater than zero.'
local overdraw_error        = 'Amount cannot be greater than the balance.'

function BankAccount:new()
  local bank_account = {}
  setmetatable(bank_account, self)
  self.__index = self

  self.balance_amount = 0
  self.is_open = true

  return bank_account
end

function BankAccount:balance()
  if not self.is_open then error(closed_account_error) end
  return self.balance_amount
end

function BankAccount:deposit(amount)
  if not self.is_open then error(closed_account_error) end
  if amount <= 0 then error(negative_amount_error) end
  self.balance_amount = self.balance_amount + amount
end

function BankAccount:withdraw(amount)
  if not self.is_open then error(closed_account_error) end
  if amount <= 0 then error(negative_amount_error) end
  if amount > self.balance_amount then error(overdraw_error) end

  self.balance_amount = self.balance_amount - amount
end

function BankAccount:close()
  self.is_open = false
end

return BankAccount
