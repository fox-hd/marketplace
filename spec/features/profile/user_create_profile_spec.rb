require 'rails_helper'

feature 'user create profile' do
  scenario 'must be sign in' do

    visit profiles_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end

  scenario 'from index page' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_link('Completar cadastro',href: new_profile_path)
  end
  
  scenario 'sucessfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Completar cadastro'
    fill_in 'Nome', with: 'Fulano Assis'
    fill_in 'Nome social', with: 'Fulano'
    fill_in 'Data de nascimento', with: '12/10/1984'
    fill_in 'Departamento', with: 'RH'
    fill_in 'Cargo', with: 'Gerente de RH'
    fill_in 'CPF', with: '068.133.970-52'
    click_on 'Salvar'

    expect(page).to have_content('Fulano Assis')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('12/10/1984')
    expect(page).to have_content('RH')
    expect(page).to have_content('Gerente de RH')
    expect(page).to have_content('068.133.970-52')
    expect(page).to have_content('fulano@bombril.com')
    expect(page).to have_content('Bombril')
  end

  scenario 'must fill all fields' do 
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Completar cadastro'
    fill_in 'Nome', with: ''
    fill_in 'Nome social', with: ''
    fill_in 'Data de nascimento', with: ''
    fill_in 'Departamento', with: ''
    fill_in 'Cargo', with: ''
    fill_in 'CPF', with: ''
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count:6)
  end
end