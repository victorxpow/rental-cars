require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successufully' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Saúde'

    expect(page).to have_content('Saúde')
    expect(page).to have_content('00.000.000/0000-0')
    expect(page).to have_content('Avenue Jabaquara, 1469')
  end

  scenario ' and return to home page' do
    user = User.create!(email: 'teste@teste.com', password: '123456')
    create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Saúde'
    click_on 'Home'

    expect(current_path).to eq(root_path)
  end

  scenario 'and must be authenticated via button' do
    visit root_path

    expect(page).not_to have_link('Filiais')
  end

  scenario 'and must be authenticated via route' do
    visit subsidiaries_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated to view details' do
    visit subsidiary_path(0o00000)

    expect(current_path).to eq(new_user_session_path)
  end
end
