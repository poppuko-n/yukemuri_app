class Tax
  RATE = '10'.freeze

  class << self

    def tax_price(price)
      price_bd = BigDecimal(price.to_s)
      tax_bd = BigDecimal(RATE)

      (price_bd * tax_bd / 100).floor
    end

    def tax_included_price(price)
      price + tax_price(price)
    end
  end
end
