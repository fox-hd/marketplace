require 'rails_helper'

feature 'user search product' do
  scenario 'must be sign in' do
    
    visit root_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end

  scenario 'and find exact match by name' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Bicicleta vermelha', description: 'Caloi , 18 marchas, aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '882.608.130-17')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 4000, category: 'Eletronicos', profile: another_profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta azul', description: 'Modelo XKS, 18 marchas, aro 29', 
                    price: 3000, category: 'Esporte e Lazer', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Bombril', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'fulano@assolan.com', 
                                password: '12345678', company: company_bombril)
    profile_assolan = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_assolan, user:user_assolan, cpf: '143.585.390-33')
    Product.create!(name: 'Bicicleta verde', description: 'Caloi , 18 marchas, aro 29', 
                    price: 1200, category: 'Esporte e Lazer', profile: profile_assolan, company: company_assolan)

    sicrano_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as sicrano_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    fill_in 'Pesquisar produtos', with: 'Bicicleta vermelha'
    click_on 'Pesquisar'

    expect(page).to have_content('Bicicleta vermelha')
    expect(page).to have_content('2.000,00')
    expect(page).not_to have_content('Bicicleta azul')
    expect(page).not_to have_content('3.000,00')
    expect(page).not_to have_content('Computador')
    expect(page).not_to have_content('4000')
    expect(page).not_to have_content('Bicicleta verde')
    expect(page).not_to have_content('1.200,00')
    expect(page).to have_link('Voltar para loja', href: products_path)
  end

  scenario 'and not match' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Bicicleta vermelha', description: 'Caloi , 18 marchas, aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '882.608.130-17')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 4000, category: 'Eletronicos', profile: another_profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta azul', description: 'Modelo XKS, 18 marchas, aro 29', 
                    price: 3000, category: 'Esporte e Lazer', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Bombril', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'fulano@assolan.com', 
                                password: '12345678', company: company_bombril)
    profile_assolan = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_assolan, user:user_assolan, cpf: '143.585.390-33')
    Product.create!(name: 'Bicicleta verde', description: 'Caloi , 18 marchas, aro 29', 
                    price: 1200, category: 'Esporte e Lazer', profile: profile_assolan, company: company_assolan)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    fill_in 'Pesquisar produtos', with: 'Cadeira'
    click_on 'Pesquisar'


    expect(page).not_to have_content('Bicicleta vermelha')
    expect(page).not_to have_content('Bicicleta azul')
    expect(page).not_to have_content('Computador')
    expect(page).not_to have_content('Bicicleta verde')
    expect(page).to have_link('Voltar para loja', href: products_path)
  end

  scenario 'and find partial match by name' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Bicicleta vermelha', description: 'Caloi , 18 marchas, aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '882.608.130-17')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 4000, category: 'Eletronicos', profile: another_profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta azul', description: 'Modelo XKS, 18 marchas, aro 29', 
                    price: 3000, category: 'Esporte e Lazer', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Bombril', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'fulano@assolan.com', 
                                password: '12345678', company: company_bombril)
    profile_assolan = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_assolan, user:user_assolan, cpf: '143.585.390-33')
    Product.create!(name: 'Bicicleta verde', description: 'Caloi , 18 marchas, aro 29', 
                    price: 1200, category: 'Esporte e Lazer', profile: profile_assolan, company: company_assolan)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    fill_in 'Pesquisar produtos', with: 'Bicicleta'
    click_on 'Pesquisar'

    expect(page).to have_content('Esporte e Lazer')
    expect(page).to have_content('Bicicleta azul')
    expect(page).to have_content('Esporte e Lazer')
    expect(page).to have_content('Bicicleta vermelha')
    expect(page).not_to have_content('Computador')
    expect(page).not_to have_content('Eletronicos')
    expect(page).not_to have_content('Bicicleta verde')
    expect(page).to have_link('Voltar para loja', href: products_path)
  end

  scenario 'and find match by description' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Bicicleta vermelha', description: 'Caloi , 18 marchas, aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '882.608.130-17')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 4000, category: 'Eletronicos', profile: another_profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta azul', description: 'Modelo XKS, 18 marchas, aro 29', 
                    price: 3000, category: 'Esporte e Lazer', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Bombril', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'fulano@assolan.com', 
                                password: '12345678', company: company_bombril)
    profile_assolan = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_assolan, user:user_assolan, cpf: '143.585.390-33')
    Product.create!(name: 'Bicicleta verde', description: 'Caloi , 18 marchas, aro 29', 
                    price: 1200, category: 'Esporte e Lazer', profile: profile_assolan, company: company_assolan)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    fill_in 'Pesquisar produtos', with: '18 marchas'
    click_on 'Pesquisar'

    expect(page).to have_content('Bicicleta azul')
    expect(page).to have_content('Bicicleta vermelha')
    expect(page).not_to have_content('Computador')
    expect(page).not_to have_content('Bicicleta verde')
    expect(page).to have_link('Voltar para loja', href: products_path)
  end

  scenario 'and find match by category' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Bicicleta vermelha', description: 'Caloi , 18 marchas, aro 29', 
                    price: 2000, category: 'Esporte e Lazer', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '882.608.130-17')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 4000, category: 'Eletronicos', profile: another_profile_bombril, company: company_bombril)
    Product.create!(name: 'Bicicleta azul', description: 'Modelo XKS, 18 marchas, aro 29', 
                    price: 3000, category: 'Esporte e Lazer', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Bombril', email: 'teste@assolan.com.br')
    user_assolan = User.create!(email: 'fulano@assolan.com', 
                                password: '12345678', company: company_bombril)
    profile_assolan = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_assolan, user:user_assolan, cpf: '143.585.390-33')
    Product.create!(name: 'Bicicleta verde', description: 'Caloi , 18 marchas, aro 29', 
                    price: 1200, category: 'Esporte e Lazer', profile: profile_assolan, company: company_assolan)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    fill_in 'Pesquisar produtos' , with:'Esporte e Lazer'
    click_on 'Pesquisar'

    expect(page).to have_content('Bicicleta azul')
    expect(page).to have_content('Bicicleta vermelha')
    expect(page).not_to have_content('Bicicleta verde')
    expect(page).not_to have_content('Computador')
    expect(page).to have_link('Voltar para loja', href: products_path)
  end
end