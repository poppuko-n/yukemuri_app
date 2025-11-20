class Tax
  RATE = '1.10'.freeze

  def self.calculate_with_tax(price)
    (BigDecimal(price.to_s) * BigDecimal(RATE)).floor
  end
end
