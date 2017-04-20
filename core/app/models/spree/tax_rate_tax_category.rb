module Spree
  class TaxRateTaxCategory < Spree::Base
    belongs_to :tax_rate, class_name: Spree::TaxRate
    belongs_to :tax_category, class_name: Spree::TaxCategory
  end
end
