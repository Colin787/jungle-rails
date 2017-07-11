require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be valid when all fields are filled correctly' do
      user = User.create(name: 'Colin Park',
                         email: "colinpark4@gmail.com",
                         password: "12345",
                         password_confirmation: '12345')
      expect(user).to be_valid                       
    end

    it 'should not work if mismatched passwords' do
      user = User.create(name: 'Colin Park',
                         email: "colinpark4@gmail.com",
                         password: "12345",
                         password_confirmation: '2345')
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")                       
    end

    it 'should not allow password to be blank' do
      user = User.create(name: 'Colin Park',
                         email: "colinpark4@gmail.com",
                         password: nil,
                         password_confirmation: '12345')
      expect(user.errors.full_messages).to include("Password can't be blank")                       
    end

    it 'should have password confirmation' do
      user = User.create(name: 'Colin Park',
                         email: 'colinpark4@gmail.com',
                         password: '122313',
                         password_confirmation: nil)
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end 

    it 'should have unique emails' do
      user = User.create(name: 'Colin Park',
                         email: "colinpark4@gmail.com",
                         password: '12345',
                         password_confirmation: '12345')

                         
      not_unique_user = User.create(name: 'Colin Park',
                                    email: "COLINPARK4@gmail.com",
                                    password: '12345',
                                    password_confirmation: '12345')                   
      
      expect(not_unique_user.errors.full_messages).to include("Email has already been taken")
    end 

    it 'should not have blank email' do
      user = User.create(name: 'colin',
                         email: nil, 
                         password: '1234',
                         password_confirmation: '1234')
      expect(user.errors.has_key?(:email)).to be_falsy
    end 


    it 'should have name' do
      user = User.create(name: nil,
                         email: 'c@c.com', 
                         password: '1234',
                         password_confirmation: '1234')
      expect(user.errors.has_key?(:name)).to be_truthy
    end

    it 'should have a password at least 3 chars long' do
      user = User.create(name: 'colin',
                         email: 'c@c.com', 
                         password: '1',
                         password_confirmation: '1')
      expect(user.errors.full_messages).to include('Password is too short (minimum is 3 characters)')
    end 
  end

    describe '.authenticate_with_credentials' do
      it 'should match password and email' do
        user = User.create(name: 'colin', 
                           email: 'c@c.com',
                            password: '123',
                            password_confirmation: '123')
        session = User.authenticate_with_credentials('c@c.com', '123')
        expect(session).to eq user
      end

      it 'should not login with incorrect pw and/or email' do
        user = User.create(name: 'colin',
                           email: 'c@c.com', 
                           password: '123',
                           password_confirmation: '123')
        session = User.authenticate_with_credentials('c@g.com', '123')
        expect(session).not_to eq user
      end

      it 'should not care about empty spaces after the email' do
        user = User.create(name: 'colin',
                           email: 'c@c.com',
                           password: '123',
                           password_confirmation: '123')
        session = User.authenticate_with_credentials('c@c.com  ', '123')
        expect(session).to eq user
      end

      it 'should not care about case in the email' do
        user = User.create(name: 'colin',
                           email: 'example@example.com',
                           password: '123',
                           password_confirmation: '123')
        session = User.authenticate_with_credentials('EXAMpLE@exaMPLE.com  ', '123')
        expect(session).to eq user
      end


  end  

end
