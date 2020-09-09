require 'rails_helper'

feature 'user view products' do
  scenario 'and must be sign in' do

    visit products_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'in store of own company' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)

    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)
    another_profile_bombril = Profile.create!(name: 'Scirano Assis', nick_name: 'Sicrano', date_of_birth: '12/10/1984', department:'RH',
                                              role: 'Gerente de RH', company:company_bombril, user:another_user_bombril, cpf: '549.433.460-06')
    Product.create!(name: 'Celular', description: 'Samsung S10', 
                    price: 2000, category: 'Eletronico', profile: another_profile_bombril, company: company_bombril)

    company_assolan = Company.create!(name: 'Assolan', email: 'teste@assolan.com.br')
    user_assolan = User.create!(name: 'Beltrano Assis', email: 'beltrano@assolan.com', 
                                password: '12345678', company: company_assolan)
    profile_assolan = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1986', department:'Financeiro',
                    role: 'Contador', company:company_assolan, user:user_assolan, cpf: '068.133.970-52')
    
    Product.create!(name: 'Bicicleta', description: 'Bicicleta XKS aro 29, cambio shimano, freio a disco', 
                    price: 450, category: 'Esporte e Lazer' ,profile: profile_assolan, company: company_assolan)
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'

    expect(page).to have_content('Computador')
    expect(page).to have_content('Celular')
    expect(page).not_to have_content('Bicicleta')
  end

  scenario 'of store and view details product' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    another_user_bombril = User.create!(email: 'sicrano@bombril.com', 
                                        password: '12345678', company: company_bombril)

    login_as another_user_bombril, scope: :user
    visit root_path
    click_on 'Loja'
    click_on 'Computador'

    expect(page).to have_content('Categoria')
    expect(page).to have_content('Computador')
    expect(page).to have_content('PC tela LCD, 16 Ram, 1TB HD, I5')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Eletronico')
    expect(page).to have_content('Fulano Assis')
    expect(page).to have_link('Voltar', href:products_path)
    expect(page).not_to have_link('Editar')
  end

  scenario 'registered in your profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Product.create!(name: 'Computador', description: 'PC tela LCD, 16 Ram, 1TB HD, I5', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    Product.create!(name: 'Teclado', description: 'Modelo Yahama, apenas 1 ano de uso', 
                    price: 2000, category: 'Eletronico', profile: profile_bombril, company: company_bombril)
    
    company_assolan = Company.create!(name: 'Assolan', email: 'teste@assolan.com.br')
    user_assolan = User.create!(name: 'Beltrano Assis', email: 'beltrano@assolan.com', 
                                password: '12345678', company: company_assolan)
    profile_assolan = Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1986', department:'Financeiro',
                    role: 'Contador', company:company_assolan, user:user_assolan, cpf: '068.133.970-52')
    Product.create!(name: 'Bicicleta', description: 'Bicicleta XKS aro 29, cambio shimano, freio a disco', 
                    price: 450, category: 'Esporte e Lazer' ,profile: profile_assolan, company: company_assolan)


    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Loja'

    expect(page).to have_content('Computador')
    expect(page).to have_content('Teclado')
    expect(page).not_to have_content('Bicicleta')
  end
end
