require 'rails_helper'

feature 'seller receive notification about product' do
  scenario 'and view notification about order' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :waiting)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?')
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    
    expect(page).to have_content('Aguardando confirmação de venda')
    expect(page).to have_content('Computador')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('Ver detalhes')
  end

  scenario 'and view details about order' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :waiting)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?')
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('RH')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('755.755.510-40')
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
                              price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril, status: :waiting)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1985', department:'Marketing',
                                              role: 'Gerente de marketing', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')
    order = Order.create!(product:product, profile: another_profile_bombril, body: 'Podemos combinar a entrega?')
    
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
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('12/10/1985')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Confirmar venda')
    expect(page).to have_content('Cancelar venda')
    expect(page).to have_content('Essa venda foi finalizada')
  end


end