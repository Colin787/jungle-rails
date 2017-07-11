require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    before(:each) do
      @category = Category.create({name: 'Apparel'})
    end

    it 'should have all params' do 
      product = Product.create({name: 'abc', 
                                description: 'hey there',
                                category_id: @category.id, 
                                quantity: 1,
                                price: 14000})
      expect(product).to be_valid                          
    end

    it 'should not be valid when name is nil' do
      product = Product.create(name: nil,
                                description: 'this is cool',
                                category_id: @category.id,
                                quantity: 1,
                                price: 4000 )  
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not be valid if the price is nil' do
      product = Product.create(name: 'hey',
                               description: 'yoooo',
                               category_id: @category.id,
                               quantity: 1, 
                               price: nil)
      expect(product.errors.full_messages).to include("Price can't be blank")
    end 
    
    it 'should not be valid if the quantity is nil' do
      product = Product.create(name: 'habid',
                               description: 'hey',
                               category_id: @category.id, 
                               quantity: nil, 
                               price: 1000)
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end 

    it 'should not be valid if the category is nil' do
      product = Product.create(name: 'adad',
                               description: 'dsdacafa', 
                               category_id: nil,
                               quantity: 1,
                               price: 1000)
      expect(product.errors.full_messages).to include("Category can't be blank")
    end 

  end
end  
