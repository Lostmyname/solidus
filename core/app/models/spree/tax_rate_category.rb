module Spree
  class TaxRateCategory < Spree::Base
    self.table_name = "spree_tax_rates_categories"

    belongs_to :tax_rate, class_name: Spree::TaxRate
    belongs_to :tax_category, class_name: Spree::TaxCategory
  end
end
