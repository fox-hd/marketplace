require 'rails_helper'

feature 'user visit page product to buy' do
  scenario 'and must be sign in' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product_bombril = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)

    visit product_path(product_bombril)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and only view details' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '286.354.530-26')

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'
    click_on 'Comprar produto'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('12/10/1984')
    expect(page).to have_content('RH')
    expect(page).to have_content('Gerente de RH')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('286.354.530-26')
    expect(page).to have_content('12/10/1985')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Gerente de marketing')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
  end

  scenario 'and buy if have completed profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '286.354.530-26')

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'
    click_on 'Comprar produto'
    fill_in 'Observações', with: 'Gostaria de retirar em mãos'
    click_on 'Finalizar compra'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Compra efetuada com sucesso, aguarde confirmação do vendedor')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'but seller cannot buy own product' do 
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).not_to have_link('Comprar produto', href: new_product_order_path(product))
  end

  scenario 'and cannot buy if user not have completed profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)
    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'


    expect(page).not_to have_link('Comprar produto', href: new_product_order_path(product))
  end

  scenario 'and have order canceled' do 
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '286.354.530-26')

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'
    click_on 'Comprar produto'
    fill_in 'Observações', with: 'Gostaria de retirar em mãos'
    click_on 'Finalizar compra'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Eletronico')
    expect(page).to have_content('Compra efetuada com sucesso, aguarde confirmação do vendedor')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'but seller cannot buy own product' do 
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :enable)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).not_to have_link('Comprar produto', href: new_product_order_path(product))
  end
end