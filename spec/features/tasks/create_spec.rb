# frozen_string_literal: true

require 'rails_helper'

feature 'Creating a task' do
  let!(:user) {create(:user)}
  let!(:list) { create(:list, user: user)}
  let!(:task) { create(:task, name: 'Test my app', :completed => false, :list => list) }

  before(:each) {
    login_as(user, :scope => :user)
  }

  scenario 'redirects to the tasks index page on success' do
    visit list_tasks_path(list)
    puts page.body
    click_on 'Add a task'
    expect(page).to have_content('Create a task')

    fill_in 'Name', with: 'Test my app'
    click_button 'Save'

    expect(page).to have_content('Tasks')
    expect(page).to have_content('Test my app')
  end

  scenario 'displays an error when no name is provided' do
    visit new_list_task_path(list)
    fill_in 'Name', with: ''
    click_button 'Save'

    expect(page).to have_content("Name can't be blank")
  end
end
