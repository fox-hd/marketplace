require 'rails_helper'

feature 'Company not has register' do
  scenario 'and visitor try registration' do
    Company.create!(name: 'Bombril', email: 'test@bombril.com.br')

    visit root_path
    click_on 'Registrar-se'
    fill_in 'E-mail', with: 'test@assolan.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on  'Cadastrar'

    expect(page).to have_content('Empresa não está registrada')
    expect(page).not_to have_link('Sair')
  end

  scenario 'and visitor cannot sign in' do
    Company.create!(name: 'Bombril', email: 'test@bombril.com.br')

    visit root_path
    fill_in 'E-mail', with: 'fulano@bombril.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    expect(page).to have_content('E-mail ou senha inválidos')
    expect(page).not_to have_link('Sair')
  end
end