# frozen_string_literal: true

require 'rails_helper'

feature 'Editing a list' do
  let!(:user) {create(:user)}
  let!(:list) { create(:list, user: user)}
  let!(:task) { create(:task, name: 'Test my app', completed: false, list: list) }

  before(:each) {
    login_as(user, :scope => :user)
  }

  scenario 'redirects to the lists index page on success' do
    visit lists_path
    click_on 'Edit'
    expect(page).to have_content('Editing list')

    fill_in 'Title', with: 'Test my list (updated)'
    click_button 'Save'

    expect(page).to have_content('Lists')
    expect(page).to have_content('Test my list (updated)')
  end

  scenario 'displays an error when no title is provided' do
    visit edit_list_path(list, task)
    fill_in 'Title', with: ''
    click_button 'Save'

    expect(page).to have_content("Title can't be blank")
  end

end
