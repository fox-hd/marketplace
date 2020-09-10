require 'rails_helper'

feature 'user visit product page registered' do
  scenario 'and must be sign in' do

    visit my_products_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and cannot profile registered' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus anuncios'

    expect(page).to have_content('Para comprar ou vender produtos é necessario completar o cadastro')
    expect(page).to have_link('Voltar', href: root_path)
    expect(page).to have_link('Completar cadastro', href: new_profile_path)
  end

end