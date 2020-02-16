require 'rails_helper'

feature 'Admin delete car' do
  scenario 'successfully' do
    user = create(:user)
    car = create(:car)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    within("tr#car-#{car.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Deletar'

    expect(page).to have_content('Carro deletado com sucesso')
    expect(page).to_not have_content(car)
  end

  scenario 'and must be authenticated to delete' do
    visit car_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
