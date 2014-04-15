module AuthenticationHelper

  def sign_in_as(email, password)
    create(:user, email: email, password: password, password_confirmation: password) if User.find_by_email(email).blank?
    visit root_url
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end

  def sign_out
    visit root_url
    click_link 'Sign out'
  end
end
