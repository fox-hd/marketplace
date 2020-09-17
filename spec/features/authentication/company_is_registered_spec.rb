require 'rails_helper'

feature 'visit hompage with company registered' do
  scenario 'and must be sign in' do

    visit root_path

    expect(page).to have_link('Entrar', href:new_user_session_path)
    expect(page).to have_link('Registrar-se', href:new_user_registration_path)
  end

  scenario 'and already was registrer' do
    company = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user = User.create!(name: 'Fulano Sicrano', email: 'fulano@bombril.com', 
                        password: '12345678', company: company)

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'fulano@bombril.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo ao Marketplace')
  end

  scenario 'and sign out' do
    company = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user = User.create!(name: 'Fulano Sicrano', email: 'fulano@bombril.com', 
                        password: '12345678', company: company)
    
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'fulano@bombril.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content('Bem vindo ao Marketplace')
    expect(page).not_to have_content('Login efetuado com sucesso')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and must create new registration' do
    Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')

    visit root_path
    click_on 'Registrar-se'
    fill_in 'E-mail', with: 'teste@bombril.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('Bem vindo ao Marketplace')
    expect(page).not_to have_link('Entrar')
  end
end 