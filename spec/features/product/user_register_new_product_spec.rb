require 'rails_helper'

feature 'User register new product' do
  scenario 'and must be sign in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and need to register profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_content('Nenhum perfil cadastrado')
  end

  scenario 'successfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile_bombril = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                                      role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Anunciar produto'
    fill_in 'Produto', with: 'Notebook'
    fill_in 'Descrição', with: 'Modelo Dell Inspiron, 15 pol, 1TB HD, 16ram, i7'
    fill_in 'Preço', with: '2000'
    select 'Eletronicos', from: 'Categoria'
    click_on 'Anunciar'

    expect(page).to have_content('Notebook')
    expect(page).to have_content('Modelo Dell Inspiron, 15 pol, 1TB HD, 16ram, i7')
    expect(page).to have_content('2.000,00')
    expect(page).to have_content('Eletronico')
  end
end