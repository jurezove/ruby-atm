ruby-atm
========

A simple Ruby app simulating an ATM

The RubyATM class allows you to withdraw or deposit a specified amount and returns a hash of bank notes and their count. Deposits add to the ATM's balance and withdrawals subtract.

# Usage
Initialize RubyATM with the default balance

`atm = RubyATM.new`

Withdraw 540 and get one 500 note and two 20 notes.

`atm.withdraw(540) # { 500 => 1, 20 => 2 }`

Deposit 1200

`atm.deposit(540) # { 500 => 2, 50 => 4 }`

## Evil ATM Mode

If `EVIL_ATM` is set to `true`, the ATM will always return the smallest possible notes for the requested withdrawal amount. EVIL! :)

# Testing (minitest)
`ruby test_ruby_atm.rb`

# Todo
Handle a case in which the ATM doesnt have small enough notes for the specified amount.
