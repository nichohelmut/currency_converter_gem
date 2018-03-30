require "currency_converter_gem_nichohelmut/version"

module CurrencyConverterGemNichohelmut
class Money
    attr_accessor :amount, :converted_amount

    def initialize(amount, from_curr)
      @amount = amount
      @from_curr = from_curr
    end

    def amount
      @amount
    end

    def from_curr
      @from_curr
    end

    def inspect
      '%.2f' % @amount.to_s + " " + @from_curr
    end


 def self.conversion_rates(attr = {})
      # @conv_rates = {from_curr = {rates}} Use Hard Code for now
      # refactor to attr ={}
      return {'EUR'=>{'USD'=>1.23, 'Bitcoin'=>0.00016},
      'USD'=>{'EUR'=>0.81, 'Bitcoin'=>0.00013},
      'Bitcoin'=>{'USD'=>7468.23, 'EUR'=>6557.93}}


    end

    def convert_to(to_curr)
      if to_curr != self.from_curr
        @rate = Money.conversion_rates[self.from_curr]["#{to_curr}"]
        @converted_amount = @amount * @rate
        Money.new(@converted_amount, to_curr)
      else
        Money.new(@amount, from_curr)
      end
    end

  def +(other)
    curr = self.from_curr
    result = self.amount + other.convert_to(curr).amount
    return Money.new(result, curr)
  end

  def -(other)
    curr = self.from_curr
    result = self.amount - other.convert_to(curr).amount
    return Money.new(result, curr)
  end

  def *(other)
    result = self.amount * other
    Money.new(result, self.from_curr)
  end

  def /(other)
    result = self.amount / other
    Money.new(result, self.from_curr)
  end

 def ==(other)
    curr = self.from_curr
    result = (self.amount == other.convert_to(curr).amount)
  end

  def >(other)
    curr = self.from_curr
    self.amount > other.convert_to(curr).amount
  end

  def <(other)
    curr = self.from_curr
    self.amount < other.convert_to(curr).amount
  end
end

twenty_dollars = Money.new(20, "USD")
fifty_euro = Money.new(50, "EUR")

end
