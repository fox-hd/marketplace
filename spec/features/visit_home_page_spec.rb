require 'rails_helper'

feature 'user visit home page' do
  scenario 'and must be sign in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and successfully' do
    user = User.create!(name: 'Fulano Sicrano', email: 'fulano@sicrano.com', 
                        password: '12345678')

    visit root_path
    fill_in 'E-mail', with: 'fulano@sicrano.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    

    expect(page).to have_content('Fulano Sicrano')
    expect(current_path).to eq root_path
    expect(page).to have_content('Marketplace')
  end

  scenario 'and sign out' do
    User.create!(name: 'Fulano Sicrano', email:'fulano@sicrano.com', 
                 password:'12345678')

    visit root_path
    fill_in 'E-mail', with: 'fulano@sicrano.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).not_to have_content('Fulano Sicrano')
    expect(page).not_to have_content('Login efetuado com sucesso')
    expect(page).not_to have_link('Sair')
  end
end