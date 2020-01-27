require 'rails_helper'

feature 'Admin delete car' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        car = FactoryBot.create(:car)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Carros'
        click_on 'Kwid'
        click_on 'Deletar'

        expect(page).to have_content('Excluído com sucesso')
    end
end