module AuthenticationHelper

  def sign_in_as(email, password)
    create(:user, email: email, password: password, password_confirmation: password)
    visit root_url
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Sign in'
  end
end
