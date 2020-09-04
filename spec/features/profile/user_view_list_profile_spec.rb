require 'rails_helper'

feature 'user view list profile of company' do
  scenario 'and must be sign in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'Marketing',
                                      role: 'Gerente de Mk', company:company_bombril, user:user_bombril, cpf: '98.428.988/0001-99')
    Product.create!(name: 'Bicicleta', description: 'Modelo Mk, 18 marchas, aro 29', 
                    price: 900, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)
    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Colaboradores cadastrados'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('fulano@bombril.com')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('sicrano@bombril.com')
  end

  scenario 'but dont another company' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'Marketing',
                                      role: 'Gerente de Mk', company:company_bombril, user:user_bombril, cpf: '98.428.988/0001-99')

    company_assolan = Company.create!(name: 'Assolan', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'beltrano@assolan.com', 
                                password: '12345678', company: company_assolan)
    profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'Engenharia',
                                      role: 'Engenhiro eletronico', company:company_assolan, user:user_assolan, cpf: '43.661.987/0001-06')

    login_as user_assolan, scope: :user
    visit root_path
    click_on 'Colaboradores cadastrados'

    expect(page).not_to have_content('Fulano Assis')
    expect(page).not_to have_content('fulano@bombril.com')
    expect(page).not_to have_content('Sicrano Assis')
    expect(page).not_to have_content('sicrano@bombril.com')
  end

  scenario 'and view profile details' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'Marketing',
                                      role: 'Gerente de Mk', company:company_bombril, user:user_bombril, cpf: '98.428.988/0001-99')
    Product.create!(name: 'Bicicleta', description: 'Modelo Mk, 18 marchas, aro 29', 
                    price: 900, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)
    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Colaboradores cadastrados'
    click_on 'Fulano Assis - fulano@bombril.com'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('12/10/1984')
    expect(page).to have_content('RH')
    expect(page).to have_content('Gerente de RH')
    expect(page).to have_content('fulano@bombril.com')
  end

  scenario 'and view a list of products from another profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta', description: 'Modelo XKS, 18 marchas aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)
    Product.create!(name: 'Mesa', description: 'Mesa de jantar com 6 assentos', 
                    price: 2000, category: 'Moveis', profile: profile_bombril, company: company_bombril)
   
    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Colaboradores cadastrados'
    click_on 'Fulano Assis - fulano@bombril.com'

    expect(page).to have_content('Computador')
    expect(page).to have_content('Bicicleta')
    expect(page).to have_content('Mesa')
  end
end