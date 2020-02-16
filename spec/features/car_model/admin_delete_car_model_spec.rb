require 'rails_helper'

feature 'Admin delete car model' do
  scenario 'successfully' do
    user = create(:user)
    car_model = create(:car_model)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    within("tr#car_model-#{car_model.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Deletar'

    expect(page).to have_content('Modelo do carro deletado com sucesso')
    expect(page).to_not have_content(car_model)
    expect(page).to_not have_content(car_model.name)
  end
  scenario 'and must be authenticated to delete' do
    visit car_model_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
