require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successufully' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within("tr#subsidiary-#{subsidiary.id}") do
      find('.ls-ico-zoomin').click
    end

    expect(page).to have_content('Saúde')
    expect(page).to have_content('00.000.000/0000-0')
    expect(page).to have_content('Avenida Square, 552')
  end

  scenario ' and return to home page' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within("tr#subsidiary-#{subsidiary.id}") do
      find('.ls-ico-zoomin').click
    end
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
