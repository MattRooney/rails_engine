FactoryGirl.define do

  factory :customer do
    first_name "Customer First"
    last_name "Customer Last"

    factory :customer_with_invoices do
      transient do
        invoices_count 5
      end
    end

    factory :customer_with_transactions do
      transient do
        transactions_count 3
      end
    end
  end

  factory :merchant do
    name "Merchant Name"
  end

  factory :invoice do
    status "status"
    customer
    merchant
  end

  factory :invoice_item do
    quantity 11
    unit_price 999
    invoice
    item
  end

  factory :item do
    name "items name"
    description "item description"
    unit_price 999
    merchant
  end

  factory :transaction do
    credit_card_number "1234567891234567"
    result "result"
    invoice
  end
end
