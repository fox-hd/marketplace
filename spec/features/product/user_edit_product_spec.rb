require 'rails_helper'

feature 'user edit product registered' do
  scenario 'and must be sign in' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril, status: :enable)

    visit edit_product_path(product)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril, status: :enable)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Computador'
    click_on 'Editar anuncio'

    fill_in 'Produto', with: 'Bicicleta'
    fill_in 'Descrição', with: 'Modelo XKS 18 amrchas, aro 29'
    fill_in 'Preço', with: '900'
    select 'Esporte e Lazer', from: 'Categoria'
    click_on 'Anunciar'

    expect(page).to have_content('Bicicleta')
    expect(page).to have_content('Modelo XKS 18 amrchas, aro 29')
    expect(page).to have_content('900')
    expect(page).to have_content('Esporte e Lazer')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'and attributes cannot be blank' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril, status: :enable)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Computador'
    click_on 'Editar anuncio'

    fill_in 'Produto', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Preço', with: ''
    click_on 'Anunciar'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_link('Voltar', href: product_path(product))
  end
end