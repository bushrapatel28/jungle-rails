require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should successfully save product with all four fields set' do
      @category = Category.new(name: "Perennials")

      @product = Product.new(name: "Lavendar", price: 2000, quantity: 6, category: @category)
      @product.save

      expect(@product.errors.full_messages).to be_empty
    end
    
    it 'should show an error for empty product name' do
      @category = Category.new(name: "Annuals")

      @product = Product.new(name: "", price: 4300, quantity: 17, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should show an error for empty product price' do
      @category = Category.new(name: "Fern")

      @product = Product.new(name: "Delta Maidenhair", price: "", quantity: 14, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'should show an error for empty product quantity' do
      @category = Category.new(name: "Aquatic")

      @product = Product.new(name: "Water Arum", price: 68000, quantity: "", category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should show an error for empty product category' do
      @category = Category.new(name: "Climbers")

      @product = Product.new(name: "Silver Vine", price: 5500, quantity: 20, category: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
