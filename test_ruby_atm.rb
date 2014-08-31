require 'minitest/autorun'
require './ruby_atm'

class TestRubyATM < MiniTest::Test
  def setup
    @atm = RubyATM.new
  end

  # Exceptions

  def test_max_withdrawal_exception
    assert_raises WithdrawalAmountTooHigh do
      @atm.withdraw(RubyATM::MAX_WITHDRAWAL + 10)
    end
  end

  def test_min_withdrawal_exception
    assert_raises WithdrawalAmountTooLow do
      @atm.withdraw(-100)
    end
  end

  def test_invalid_withdrawal_exception
    assert_raises WithdrawalAmountInvalid do
      @atm.withdraw(125)
    end
  end

  def test_invalid_deposit_exception
    assert_raises DepositAmountInvalid do
      @atm.deposit({50 => 10, 20 => 10, 5 => 10})
    end
  end

  # Testing withdrawals default ATM balance: { 10 => 10, 20 => 10, 50 => 10, 100 => 10, 200 => 10, 500 => 1 }

  def test_withdrawal_50
    assert_equal({50 => 1}, @atm.withdraw(50))
  end

  def test_withdrawal_450
    assert_equal({200 => 2, 50 => 1}, @atm.withdraw(450))
  end

  def test_withdrawal_450
    assert_equal({500 => 1, 100 => 1, 50 => 1, 20 => 1, 10 => 1}, @atm.withdraw(680))
  end

  def test_withdrawal_1290
    assert_equal({500 => 1, 200 => 3, 100 => 1, 50 => 1, 20 => 2}, @atm.withdraw(1290))
  end

  # Testing deposits

  def test_deposit_500
    @atm.withdraw(2000)
    @atm.withdraw(2000)
    @atm.withdraw(300)

    deposit = {50 => 8, 10 => 10}
    @atm.deposit(deposit)

    assert_equal(deposit, @atm.withdraw(500))
  end

end