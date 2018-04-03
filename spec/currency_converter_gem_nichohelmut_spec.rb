require_relative '../lib/currency_converter_gem_nichohelmut'

RSpec.describe CurrencyConverterGemNichohelmut do
  it "0.1.0" do
    expect(CurrencyConverterGemNichohelmut::VERSION).not_to be nil
  end

  describe Money do
   context 'When testing the methods' do
    # define variables
    amount1 = 20
    amount2 = 50
    curr1 = "USD"
    curr2 = "EUR"

    m1 = Money.new(amount1, curr1)
    m2 = Money.new(amount2, curr2)

    Money.conversion_rates({'EUR'=>{'USD'=>1.2, 'Bitcoin'=>0.0047},
    'USD'=>{'EUR'=>0.8, 'Bitcoin'=>0.0097},
    'Bitcoin'=>{'USD'=>1.11, 'EUR'=>0.0047}})

    # focus on writing the test logic
      it "calling amount method on an instance returns the amount" do
        expect(m1.amount).to eq 20
      end

      it "calling currency method on an instance returns the currency" do
        expect(m1.curr).to eq "USD"
      end

      it "calling inspect method on an istance returns the amount and the currency in a string" do
        expect(m1.inspect).to eq "20.00 USD"
      end

      it "calling convert_to method on an instance returns an instance with the specified currency and the converted amount" do
        r = m1.convert_to(curr2)
        expect(r.amount).to eq m1.convert_to(curr2).amount
        expect(r.curr).to eq m1.convert_to(curr2).curr
      end

      it "convert_to method does not convert the instance if the specified currency is the same as the original currency" do
        r = m1.convert_to(curr1)
        expect(r.amount).to eq m1.amount
        expect(r.curr).to eq m1.curr
      end

      it "returns an instance, with the amount in the currency of the first instance when addition operator is used" do
        r = m1 + m2
        expect(r.amount).to eq m1.amount + (m2.amount * Money.conversion_rates[m2.curr][m1.curr])
        expect(r.curr).to eq m1.curr
      end

      it "returns an instance, with the amount in the currency of the first instance when subtraction operator is used" do
        r = m2 - m1
        expect(r.amount).to eq m2.amount - (m1.amount * Money.conversion_rates[m1.curr][m2.curr])
        expect(r.curr).to eq m2.curr
      end

      it "returns an instance, with multiplied amount when multiplication operator is used" do
        r = m2 * 3
        expect(r.amount).to eq m2.amount * 3
      end

      it "returns an instance, with divided amount when division operator is used" do
        r = m2 / 3
        expect(r.amount).to eq m2.amount / 3
      end

      it "returns true, when two instances are compared and the both have the same instance variables" do
        expect(m1 == Money.new(20, "USD")).to eq true
      end

      it "returns true, when two instances are compared and the both have the same amount in a currency" do
        expect(m1 == Money.new(16, "EUR")).to eq true
      end

      it "returns false, when two instances are compared and the both don't have the same amount in a currency" do
        expect(m1 == Money.new(18, "EUR")).to eq false
      end

      it "returns true, when two instances are compared by > and the first instance is bigger than the second one" do
        expect(m1 > Money.new(5, "EUR")).to eq true
      end

      it "returns false, when two instances are compared by > and the first instance is smaller than the second one" do
        expect(m1 > Money.new(100, "EUR")).to eq false
      end

      it "returns true, when two instances are compared by < and the second instance is bigger than the first one" do
        expect(m1 < Money.new(100, "EUR")).to eq true
      end

      it "returns false, when two instances are compared by < and the second instance is smaller than the first one" do
        expect(m1 < Money.new(5, "EUR")).to eq false
      end
   end
end

end
end
