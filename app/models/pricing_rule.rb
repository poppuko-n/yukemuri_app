class PricingRule
  CHILD_RATE = '0.70'.freeze

  def self.child_price(base_price)
    (BigDecimal(base_price.to_s) * BigDecimal(CHILD_RATE)).floor
  end
end
