module LoginAs
  def login_as(user, password = '123456')
    click_link('Logout') if page.body =~ /Logout/
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button('Sign in')
  end
end

RSpec.configure do |c|
  c.include LoginAs
end
