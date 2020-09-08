require 'rails_helper'

feature 'seller visit page product' do
  scenario 'and view someone answers' do
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
    comment = Comment.create!(body:'O computador tem alguma garantia?', profile: another_profile_bombril, product: product_bombril)
    Answer.create!(body: 'Posso dar 3 meses de garantia', comment:comment)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    find('nav').click_link('Computador')
    
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('O computador tem alguma garantia?')
    expect(page).to have_content('Posso dar 3 meses de garantia')
    expect(page).to have_link('Voltar', href: products_path)
  end

  scenario 'and answear a question about product' do
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
    Comment.create!(body:'O computador tem alguma garantia?', profile: another_profile_bombril, product: product_bombril)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    find('nav').click_link('Computador')
    fill_in 'Responder', with: 'Posso dar 3 meses de garantia'
    click_on 'Enviar resposta'

    expect(page).to have_content('')
    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('Sicrano Assis')
    expect(page).to have_content('O computador tem alguma garantia?')
    expect(page).to have_content('Posso dar 3 meses de garantia')
    expect(page).to have_link('Voltar', href: products_path)
  end
end