require 'rails_helper'

feature 'user edit profile' do
  scenario 'must be sign in' do

    visit root_path

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content('Para continuar, faça login ou registre-se')
  end

  scenario 'sucessfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                    role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Fulano Assis'
    click_on 'Editar dados'

    fill_in 'Nome', with: 'Beltrano Assis'
    fill_in 'Nome social', with: 'Beltrano'
    fill_in 'Data de nascimento', with: '12/10/1990'
    fill_in 'Departamento', with: 'Marketing'
    fill_in 'Cargo', with: 'Gerente de Marketing'
    fill_in 'CPF', with: '780.362.510-00'
    click_on 'Salvar'

    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('Beltrano')
    expect(page).to have_content('12/10/1990')
    expect(page).to have_content('Marketing')
    expect(page).to have_content('Gerente de Marketing')
    expect(page).to have_content('fulano@bombril.com')
    expect(page).to have_content('Bombril')
    expect(page).to have_link('Voltar', href: profiles_path)
  end

  scenario 'attributes cannot be blank' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    profile = Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                    role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    
    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Fulano Assis'
    click_on 'Editar dados'

    fill_in 'Nome', with: ''
    fill_in 'Nome social', with: ''
    fill_in 'Data de nascimento', with: ''
    fill_in 'Departamento', with: ''
    fill_in 'Cargo', with: ''
    fill_in 'CPF', with: ''
    click_on 'Salvar'

    expect(page).to have_content('não pode ficar em branco', count: 6)
    expect(page).to have_link('Voltar', href: profile_path(profile))
  end
end