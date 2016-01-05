require 'csv'

namespace :data do
  desc "Import the customers, invoice_items, invoices, items, merchants, and
        transactions CSV files into the database"

  task :import => :environment do

    customers_path = "#{Rails.root}/lib/assets/customers.csv"
    CSV.foreach(customers_path, :headers => true) do |row|
      customer =  Customer.create!(row.to_hash)
      puts "Imported #{customer.first_name} #{customer.last_name} customer" if customer.persisted?
    end

    merchants_path = "#{Rails.root}/lib/assets/merchants.csv"
    CSV.foreach(merchants_path, :headers => true) do |row|
      merchant =  Merchant.create!(row.to_hash)
      puts "Imported #{merchant.name} merchant" if merchant.persisted?
    end

    items_path = "#{Rails.root}/lib/assets/items.csv"
    CSV.foreach(items_path, :headers => true) do |row|
      item =  Item.create!(row.to_hash)
      puts "Imported Item #{item.name}" if item.persisted?
    end

    invoices_path = "#{Rails.root}/lib/assets/invoices.csv"
    CSV.foreach(invoices_path, :headers => true) do |row|
      invoice = Invoice.create!(row.to_hash)
      puts "Imported Invoice ##{invoice.id}" if invoice.persisted?
    end

    invoice_items_path = "#{Rails.root}/lib/assets/invoice_items.csv"
    CSV.foreach(invoice_items_path, :headers => true) do |row|
      invoice_item = InvoiceItem.create!(row.to_hash)
      puts "Imported Invoice Item ##{invoice_item.id}" if invoice_item.persisted?
    end

    transactions_path = "#{Rails.root}/lib/assets/transactions.csv"
    CSV.foreach(transactions_path, :headers => true) do |row|
      transaction = Transaction.create!(row.to_hash)
      puts "Imported Transaction ##{transaction.id}" if transaction.persisted?
    end

  end
end
