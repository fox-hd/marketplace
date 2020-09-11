require 'rails_helper'


feature 'buyer and seller exchange message after on order display' do
  scenario 'buyer send message' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    fulano_user = User.create!(email: 'fulano@bombril.com', 
                               password: '12345678', company: company_bombril)
    fulano_profile = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                     role: 'Gerente de RH', company:company_bombril, user:fulano_user, cpf: '755.755.510-40')
    product_pc = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                                price: 2000, category: 'Eletronicos', profile: fulano_profile, company: company_bombril, status: :enable)

    buyer_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                      password: '12345678', company: company_bombril)
    buyer_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1987', department:'Comercial',
                                            role: 'Gerente de produtos', company:company_bombril, user:buyer_user_bombril, cpf: '286.354.530-26')
    order_pc = Order.create!(product:product_pc, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting) 

    login_as buyer_user_bombril, scope: :user
    visit root_path
    click_on 'Meus pedidos'
    click_on 'Ver detalhes'
    fill_in 'Chat', with:'Qual o prazo para entrega?'
    click_on 'Enviar'

    expect(page).to have_content('Usuário: Beltrano Assis')
    expect(page).to  have_content('Qual o prazo para entrega?')
    expect(page).to  have_content('O vendedor vai responder em breve')
  end 

  scenario 'seller answear question' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    fulano_user = User.create!(email: 'fulano@bombril.com', 
                               password: '12345678', company: company_bombril)
    fulano_profile = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                     role: 'Gerente de RH', company:company_bombril, user:fulano_user, cpf: '755.755.510-40')
    product_pc = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                                price: 2000, category: 'Eletronicos', profile: fulano_profile, company: company_bombril, status: :disable)

    buyer_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                                      password: '12345678', company: company_bombril)
    buyer_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1987', department:'Comercial',
                                            role: 'Gerente de produtos', company:company_bombril, user:buyer_user_bombril, cpf: '286.354.530-26')
    order_pc = Order.create!(product:product_pc, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting) 
    
    Chat.create!(body: 'Qual o prazo para entrega?', order: order_pc, profile: buyer_profile_bombril)
    

    login_as fulano_user, scope: :user
    visit root_path
    click_on 'Meus anuncios'
    click_on 'Ver detalhes'
    fill_in 'Chat', with:'Podemos combinar a entrega?'
    click_on 'Enviar'

    order_pc.reload
    expect(page).to have_content('Usuário: Beltrano Assis')
    expect(page).to  have_content('Qual o prazo para entrega?')
    expect(page).to have_content('Usuário: Fulano Assis')
    expect(page).to  have_content('Podemos combinar a entrega?')
  end 
end