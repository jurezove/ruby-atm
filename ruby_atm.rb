class RubyATM
  ACCEPTED_NOTES = [10, 20, 50, 100, 200, 500]
  DEFAULT_BALANCE = { 10 => 10, 20 => 10, 50 => 10, 100 => 10, 200 => 10, 500 => 1 }
  MAX_WITHDRAWAL = 2000

  EVIL_ATM = false # Always return the smallest possible notes

  def initialize(notes = DEFAULT_BALANCE)
    @balance = {}
    deposit(notes)
  end

  def withdraw(amount)
    check_withdrawal(amount)
    
    withdrawal = fetch_notes(amount)
    @balance.merge!(withdrawal){ |key, existing, withdrawal| existing - withdrawal } 

    withdrawal
  end 

  def deposit(notes)
    check_deposit(notes)

    @balance.merge!(notes){ |key, existing, deposit| existing + deposit }
  end

  private

  def fetch_notes(amount)
    withdrawn_notes = {}
    withdrawn_amount = 0

    notes = EVIL_ATM ? @balance.keys.sort : @balance.keys.sort.reverse 
    notes.each do |note|
      max_notes = (amount - withdrawn_amount) / note
      actual_notes = [@balance[note], max_notes].min
      
      if actual_notes > 0
        withdrawn_amount += actual_notes * note
        withdrawn_notes[note] = actual_notes
      end
    end

    raise WithdrawalAmountInvalid, 'Amount cannot be withdrawn. Please specify another amount.' if withdrawn_amount < amount

    withdrawn_notes
  end

  def check_withdrawal(amount)
    raise WithdrawalAmountInvalid, 'Please round to the nearest tenth.' if amount % 10 > 0
    raise WithdrawalAmountTooLow, 'Amount too low.' if amount < 0
    raise WithdrawalAmountTooHigh, "Amount too high. Max withdrawal can be #{max_withdrawal}." if amount > max_withdrawal
  end

  def check_deposit(notes)
    raise DepositAmountInvalid, "This ATM accepts only these notes: #{ACCEPTED_NOTES.join(", ")}" unless (notes.keys - ACCEPTED_NOTES).empty?
  end

  def balance
    @balance.map{ |note, count| note * count }.reduce(:+)
  end

  def max_withdrawal
    [MAX_WITHDRAWAL, balance].min
  end

end

class WithdrawalAmountTooHigh < StandardError; end
class WithdrawalAmountTooLow < StandardError; end
class WithdrawalAmountInvalid < StandardError; end
class DepositAmountInvalid < StandardError; end