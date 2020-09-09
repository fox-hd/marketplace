require 'rails_helper'

feature 'buyer visit page product' do
  scenario 'and must be sign in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and view some questions' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product_bombril = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    
    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')
    Comment.create(body:'O computador tem alguma garantia?', profile: another_profile_bombril, product: product_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('O computador tem alguma garantia?')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'and can to do someone question' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product_bombril = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                                      price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril)
    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'
    fill_in 'Comentário', with: 'Qual a garantia?'
    click_on 'Enviar'
    
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('Qual a garantia?')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario ' and without profile cannot ask about product' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    product_bombril = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                                      price: 2000, category: 'Eletronicos', profile: profile_bombril, company: company_bombril)
    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scpe: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).to have_content('Para deixar comentarios e fazer compras é necessario completar seu cadastro')
    expect(page).not_to have_content('Deixe seu comentário')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'and cannot to answer questions other buyers' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    seller_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    seller_profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:seller_bombril, cpf: '755.755.510-40')
    product_bombril = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: seller_profile_bombril, company: company_bombril)
    
    user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    user_profile_bombril = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Comment.create(body:'O computador tem alguma garantia?', profile: user_profile_bombril, product: product_bombril)

    another_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '755.755.510-40')

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).not_to have_content('Responder')
  end


end