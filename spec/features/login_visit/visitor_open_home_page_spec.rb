require 'rails_helper'

feature 'Visitor open home page' do
  scenario 'successfully' do
    visit root_path

   
    expect(current_path).to eq(new_user_session_path)
    
  end
end