require 'rails_helper'

feature 'User enable product advertisement' do
  scenario 'and must be sign in' do

    visit my_products_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and cannot enable product advertisement sold' do
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
    
    expect(page).to have_content('Produtos vendidos')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).not_to have_link('Reativar anuncio', href: enable_product_path(product))
  end

end