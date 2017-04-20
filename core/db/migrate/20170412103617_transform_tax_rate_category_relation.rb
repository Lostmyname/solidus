class TransformTaxRateCategoryRelation < ActiveRecord::Migration
  def up
    create_table :spree_tax_rates_categories do |t|
      t.integer :tax_category_id, index: true
      t.integer :tax_rate_id, index: true
    end

    add_foreign_key :spree_tax_rates_categories, :spree_tax_categories, column: :tax_category_id
    add_foreign_key :spree_tax_rates_categories, :spree_tax_rates, column: :tax_rate_id

    Spree::TaxRate.find_each do |tax_rate|
      Spree::TaxRateCategory.create!(
        tax_rate: tax_rate,
        tax_category_id: tax_rate.tax_category_id
      )
    end

    remove_column :spree_tax_rates, :tax_category_id
  end

  def down
    add_column :spree_tax_rates, :tax_category_id, :integer

    Spree::TaxRate.find_each do |tax_rate|
      if tax_rate.categories.count == 1
        tax_rate.update!(:tax_category_id, tax_rate.categories.first.id)
      else
        tax_rate.categories.each_with_index do |category, i|
          if i.zero?
            tax_rate.update!(:tax_category_id, category.id)
          else
            new_tax_rate = tax_rate.dup
            new_tax_rate.update!(:tax_category_id, category.id)
          end
        end
      end
    end

    drop_table :spree_tax_rates_categories
  end
end
