# spec/requests/registration_spec.rb
require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  it 'registers a new user' do
    post user_registration_path, params: {
      user: {
        name: 'New User',
        email: 'newuser@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
    }
    # successfully sing in redirect to the home page
    expect(response).to redirect_to(root_path)
  end

  it 'does not register a new user with invalid data' do
    post user_registration_path, params: {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
    # redirect to the registration page
    expect(response).to render_template(:new)
    expect(response.body).to include('can&#39;t be blank')
  end

  it 'does not register a new user with a password mismatch' do
    post user_registration_path, params: {
      user: {
        name: 'New User',
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password321'
      }
    }
    # redirect to the registration page
    expect(response).to render_template(:new)
    expect(response.body).to include('doesn&#39;t match Password')
  end
end
