require 'rails_helper'

feature 'Admin delete subsidiary' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        create(:subsidiary)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Filiais'
        click_on 'Saúde'
        
        click_on 'Deletar'
        
        expect(page).to have_content('Filial excluída com sucesso')
    end
end