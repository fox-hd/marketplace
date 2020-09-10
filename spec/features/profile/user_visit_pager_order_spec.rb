require 'rails_helper'

feature 'user visit pager order' do
  scenario 'and must be sign in' do

    visit orders_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and cannot profile registered' do
    company_bombril = Company.create!(name: 'Bombril', email: 'teste@bombril.com.br')
    user_bombril = User.create!(email: 'fulano@bombril.com', 
                                password: '12345678', company: company_bombril)

    login_as user_bombril, scope: :user
    visit root_path
    click_on 'Meus pedidos'

    expect(page).to have_content('Meus pedidos')
    expect(page).to have_content('Não há pedidos')    
    expect(page).to have_link('Voltar', href: root_path)
  end

end