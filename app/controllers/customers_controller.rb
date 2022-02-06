class CustomersController < ApplicationController
  def create
    salted_pw = BCrypt::Password.create('P@ssw0rd')
    render :json =>{:englon =>salted_pw}
  end
end
