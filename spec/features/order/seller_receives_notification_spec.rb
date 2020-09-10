require 'rails_helper'

feature 'seller receive notification about product' do
  scenario 'and must be sign in' do
    
    visit products_path()

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and view notification about order waiting' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    
    expect(page).to have_content('Aguardando confirmação de venda')
    expect(page).to have_content('Computador')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('Ver detalhes')
  end

  scenario 'and view details about order waiting' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('RH')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('696.136.810-78')
    expect(page).to have_content('12/10/1985')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Confirmar venda')
    expect(page).to have_content('Cancelar venda')
  end

  scenario 'and accept order' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'
    click_on 'Confirmar venda'

    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('RH')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('696.136.810-78')
    expect(page).to have_content('12/10/1985')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Essa venda foi finalizada')
    product.reload
    expect(product).to be_sold
  end

  scenario 'and canceled order' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'
    click_on 'Cancelar venda'

    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('RH')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('696.136.810-78')
    expect(page).to have_content('12/10/1985')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Venda recusada')
    expect(page).to have_content('Essa venda foi cancelada pelo vendedor')
  end

  scenario 'after confirm order cannot cancel' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'
    click_on 'Confirmar venda'

    expect(page).not_to have_link('Confirmar venda', href: accept_order_path(order))
  end

  scenario 'after cancel order cannot confirm' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :disable)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'
    click_on 'Cancelar venda'

    expect(page).not_to have_link('Essa venda foi cancelada pelo vendedor', href: accept_order_path(order))
  end

  scenario 'and view notification about product enable' do
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
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    
    expect(page).to have_content('Produtos disponiveis para venda')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Ver detalhes')
  end

  scenario 'and view notification about product sold' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :sold)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '696.136.810-78')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?', status: :accept)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    
    product.reload
    expect(page).to have_content('Produtos vendidos')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Ver detalhes')
  end
end