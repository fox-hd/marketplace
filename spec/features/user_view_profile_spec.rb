require 'rails_helper'

feature 'user profile and view your profile' do
  scenario 'sucessfully' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(name: 'Fulano Assis', email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    company_assolan = Company.create!(name: 'Assolan', email: 'teste@assolan.com.br')
    user_assolan = User.create!(name: 'Beltrano Assis', email: 'beltrano@assolan.com', 
                                password: '12345678', company: company_assolan)
    Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                    role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1986', department:'Financeiro',
                    role: 'Contador', company:company_assolan, user:user_assolan, cpf: '068.133.970-52')
    
    login_as user_assolan, scope: :user
    visit root_path
    click_on 'Meu perfil'
   

    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('beltrano@assolan.com')
    expect(page).not_to have_content('Fulano Assis')
    expect(page).not_to have_content('fulano@bombril.com')
  end

  scenario 'and view details profile' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(name: 'Fulano Assis', email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)
    company_assolan = Company.create!(name: 'Assolan', email: 'teste@assolan.com.br')
    user_assolan = User.create!(name: 'Beltrano Assis', email: 'beltrano@assolan.com', 
                                password: '12345678', company: company_assolan)
    Profile.create!(name: 'Fulano Assis', nick_name: 'Fulano', date_of_birth: '12/10/1984', department:'RH',
                    role: 'Gerente de RH', company:company_bombril, user:user_bombril, cpf: '755.755.510-40')
    Profile.create!(name: 'Beltrano Assis', nick_name: 'Beltrano', date_of_birth: '12/10/1986', department:'Financeiro',
                    role: 'Contador', company:company_assolan, user:user_assolan, cpf: '068.133.970-52')

    login_as user_assolan, scope: :user
    visit root_path
    click_on 'Meu perfil'
    click_on 'Beltrano Assis'

    expect(page).to have_content('Beltrano Assis')
    expect(page).to have_content('Beltrano')
    expect(page).to have_content('12/10/1986')
    expect(page).to have_content('Financeiro')
    expect(page).to have_content('Contador')
    expect(page).to have_content('068.133.970-52')
    expect(page).to have_content('beltrano@assolan.com')
    expect(page).to have_content('Assolan')
    expect(page).not_to have_content('Fulano Assis')
    expect(page).not_to have_content('Fulano')
    expect(page).not_to have_content('12/10/1984')
    expect(page).not_to have_content('RH')
    expect(page).not_to have_content('Gerente de RH')
    expect(page).not_to have_content('755.755.510-40')
    expect(page).not_to have_content('fulano@bombril.com')
    expect(page).not_to have_content('Bombril')
    expect(page).to have_link('Voltar', href: profiles_path)
  end

  scenario 'and dont have profile registered' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!( email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meu perfil'

    expect(page).to have_content('Nenhum perfil cadastrado')
  end
end