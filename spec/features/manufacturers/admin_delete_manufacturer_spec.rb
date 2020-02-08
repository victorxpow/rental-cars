require 'rails_helper'

feature 'Admin delete manufacturer' do
    scenario 'successfully' do
        user = User.create!(email: 'teste@teste.com', password: '123456')
        manufacturer = create(:manufacturer)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Fabricantes'
        within("tr#manufacturer-#{manufacturer.id}") do
            find('.ls-ico-zoomin').click
          end
          click_on 'Apagar'
      

        expect(page).to have_content('Fabricante deletado com sucesso')
        expect(page).to_not have_content('Fiat')
    end

    scenario 'and must be authenticated to delete' do
        visit manufacturer_path(00000)
    
        expect(current_path).to eq(new_user_session_path)
      end
end