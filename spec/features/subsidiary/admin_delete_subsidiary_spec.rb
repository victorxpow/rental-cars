require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within("tr#subsidiary-#{subsidiary.id}") do
      find('.ls-ico-zoomin').click
    end
    click_on 'Deletar'

    expect(page).to have_content('Filial deletada com sucesso')
  end

  scenario 'and must be authenticated to delete' do
    visit subsidiary_path(0o0000)

    expect(current_path).to eq(new_user_session_path)
  end
end
