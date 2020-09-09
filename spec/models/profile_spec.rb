require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      profile = Profile.new

      profile.valid?

      expect(profile.errors[:name]).to include('não pode ficar em branco')
      expect(profile.errors[:nick_name]).to include('não pode ficar em branco')
      expect(profile.errors[:date_of_birth]).to include('não pode ficar em branco')
      expect(profile.errors[:department]).to include('não pode ficar em branco')
      expect(profile.errors[:role]).to include('não pode ficar em branco')
      expect(profile.errors[:cpf]).to include('não pode ficar em branco')
    end

    it 'maximum characters allowed' do
      profile = Profile.new(name: 'Fulano Assis Fulano Assis Fulano Assis', nick_name: 'FulanoFulanoFulanoFulanoFulanoa',
                            department:'Departamento de RH,Departamento de RH', role: 'Auxiliar Assistente Auxiliar Assistente')

      profile.valid?

      expect(profile.errors[:name]).to include('São permitidos no maximo 30 caracteres')
      expect(profile.errors[:nick_name]).to include('São permitidos no maximo 30 caracteres')
      expect(profile.errors[:department]).to include('São permitidos no maximo 30 caracteres')
      expect(profile.errors[:role]).to include('São permitidos no maximo 30 caracteres')
    end

    it 'cpf must be valid' do
      profile = Profile.new(cpf:'33322223323')

      profile.valid?

      expect(profile.errors[:cpf]).to include('não é válido')
    end
  end
end
