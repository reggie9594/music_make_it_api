class CustomersController < ApplicationController
  
  # creates a Customer record, since the models Customer have the "has_secure_password" the  password will be automatically encrypted and stored in password_digest field
  def create
    @customer = Customer.create(customer_params);
    if @customer.valid?
      render :status=>201, json: @customer
    else
      render :status=>500, json: {
               error: 'Failed to create Customer',
             }
    end
  end

  #returns all Customer from the database and returs a json to the endpoint
  def customers 
    @customers=Customer.all;
    render :status =>200, json:  @customers;
  end

  # Handles login process by finding the Customer in database with the email provided 
  def login
    customer = Customer.find_by(email: customer_params[:email]);
    if authenticate(customer_params[:password],customer[:password_digest]) #check if the hashed password from db is the same as the plain password provided by Customer
    render json: {:token=>encode_token(customer), :customer => {:id =>customer[:id], :name => customer[:name], :address=>customer[:address], :email =>customer[:email]}}
    else
      # If password is wrong or Customer is not found in the db
      render :status=>401, json: {:error =>"Authentication failled"}
    end
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]

      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'my_screte_key_#2022_api_#api_customers', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_customer
    if decoded_token
      customer_id = decoded_token[0]['customer_id']
      @customer = Customer.find_by(id: customer_id)
    end
  end

  def is_authorised?
    !!current_Customer
  end

  private
  # Returns a copy of the parameters object, returning only the permitted keys and valuesReceives of data send from the client
  def customer_params
    params.require(:customer).permit(:name, :address, :email, :password);
  end

  #This function validates plain password again hashed password from database
  def authenticate(plaintext_password, hash)
    # Compaires the hashed password against paintext_password
    if BCrypt::Password.new(hash) == plaintext_password
      return true
    else
      return false
    end
  end

  # This fuction do JWT token encoding and the payload with the the fuction parameter
  def encode_token(payload)
    return JWT.encode(payload, 'my_screte_key_#2022_api_#api_customers') #JWT encording
  end
end
