require 'spec_helper'

feature 'Round 1' do
  before do
    create(:event, name: 'Rubyslava#36')
    create(:event, name: 'Rubyslava#37')
  end

  scenario 'User can see list of events' do
    user_signs_up_with('rubyslava@minio.sk', 'rubyslava')
    expect(page).to have_content('All Events')
    expect(page).to have_content('Rubyslava#36')
    expect(page).to have_content('Rubyslava#37')
  end

  scenario 'User can sign to attend any of those events' do
    user_signs_up_with('rubyslava@minio.sk', 'rubyslava')
    user_choose_to_attend('Rubyslava#37')
    expect(page).to have_content('Your Events')
    expect(find_by_id('user-events')).to have_content('Rubyslava#37')
  end

  scenario 'User can visit this page later and still see his attendance' do
    user_signs_up_with('rubyslava@minio.sk', 'rubyslava')
    user_choose_to_attend('Rubyslava#37')
    user_logs_out
    user_signs_in_with('rubyslava@minio.sk', 'rubyslava')
    expect(page).to have_content('Your Events')
    expect(find_by_id('user-events')).to have_content('Rubyslava#37')
  end
end
