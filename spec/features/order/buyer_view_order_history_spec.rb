require 'rails_helper'

feature 'user view order history' do

  scenario 'and must be sign' do

    visit orders_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'view all list order' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    fulano_user = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    fulano_profile = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:fulano_user, cpf: '755.755.510-40')
    product_pc = Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: fulano_profile, company: company_bombril, status: :enable)

    sicrano_user = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    sicrano_profile = Profile.create!(name: 'Sicrano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:sicrano_user, cpf: '549.433.460-06')
    product_celular = Product.create!(name: 'Celular', description: 'Samsung S10', 
                    price: 1000, category: 'Eletronico', profile: sicrano_profile, company: company_bombril, status: :enable)

    alano_user = User.create!(email: 'alano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    alano_profile = Profile.create!(name: 'Alano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:alano_user, cpf: '766.453.630-87')
    product_mesa = Product.create!(name: 'Mesa', description: '6 lugares, tampo de vidro e madeira de eucalipto', 
                    price: 900, category: 'Móveis', profile: alano_profile, company: company_bombril, status: :enable)

    buyer_user_bombril = User.create!(email: 'beltrano@bombril.com', 
                              password: '12345678', company: company_bombril)
    buyer_profile_bombril = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1987', department:'Comercial',
                                      role: 'Gerente de produtos', company:company_bombril, user:buyer_user_bombril, cpf: '286.354.530-26')
    order_celular = Order.create!(product:product_celular, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :waiting) 
    order_pc = Order.create!(product:product_pc, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :accept) 
    order_mesa = Order.create!(product:product_mesa, profile: buyer_profile_bombril, body: 'Pode dar um desconto?', status: :decline) 

    login_as buyer_user_bombril, scope: :user
    visit root_path
    click_on 'Meus pedidos'
    
    expect(page).to have_content('Pedidos aguardado confirmação do vendedor')
    expect(page).to have_content('Celular')
    expect(page).to have_content('1.000,00')
    expect(page).to have_content('Sicrano Assis')
    expect(order_celular).to be_waiting
    expect(page).to have_content('Pedidos finalizados')
    expect(page).to have_content('Computador')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(order_pc).to be_accept
    expect(page).to have_content('edidos cancelados pelo vendedor')
    expect(page).to have_content('Mesa')
    expect(page).to have_content('900,00')
    expect(page).to have_content('Alano Assis')
    expect(order_mesa).to be_decline
  end

  scenario 'and view details of product accept' do
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
    order_pc = Order.create!(product:product_pc, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :accept) 

    login_as buyer_user_bombril, scope: :user
    visit root_path
    click_on 'Meus pedidos'
    click_on 'Ver detalhes'

    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('Gerente de RH')
    expect(page).to have_content('Essa venda foi finalizada')
    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('286.354.530-26')
    expect(page).to have_content('12/10/1987')
    expect(page).to have_content('Comercial')
    expect(page).to have_content('Gerente de produtos')
    expect(page).not_to have_link('Confirmar venda', href: accept_order_path(order_pc))
    expect(page).not_to have_link('Cancelar venda', href: decline_order_path(order_pc))
  end

  scenario 'and view details of product waiting' do
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

    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('Aguardando confirmação do vendedor')
    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('286.354.530-26')
    expect(page).to have_content('12/10/1987')
    expect(page).to have_content('Comercial')
    expect(page).not_to have_link('Confirmar venda', href: accept_order_path(order_pc))
    expect(page).not_to have_link('Cancelar venda', href: decline_order_path(order_pc))
  end

  scenario 'and view details of product declined' do
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
    order_pc = Order.create!(product:product_pc, profile: buyer_profile_bombril, body: 'Podemos combinar a entrega?', status: :decline) 

    login_as buyer_user_bombril, scope: :user
    visit root_path
    click_on 'Meus pedidos'
    click_on 'Ver detalhes'

    expect(page).to have_content('Eletronicos')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('755.755.510-40')
    expect(page).to have_content('Essa venda foi cancelada pelo vendedor')
    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('286.354.530-26')
    expect(page).to have_content('12/10/1987')
    expect(page).to have_content('Comercial')
    expect(page).not_to have_link('Confirmar venda', href: accept_order_path(order_pc))
    expect(page).not_to have_link('Cancelar venda', href: decline_order_path(order_pc))
  end
end