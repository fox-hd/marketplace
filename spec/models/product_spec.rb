require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = Product.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:description]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:category]).to include('não pode ficar em branco')
    end
    it 'price cannot be 0' do
      product = Product.new(price: 0)

      product.valid?

      expect(product.errors[:price]).to include('deve ser maior que 0')
    end

    it 'maximun characteres allowed' do
      product = Product.new(name: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', description: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                                                                                   aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                                                                                   aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
                                                                                   aaaaaaaaaaaaaaaaaaaa')
      product.valid?

      expect(product.errors[:name]).to include('São permitidos no maximo 30 caracteres')
      expect(product.errors[:description]).to include('São permitidos no maximo 150 caracteres')
    end
  end
end
