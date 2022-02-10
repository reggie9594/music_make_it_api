class UsersController < ApplicationController
  
  # creates a user record, since the models user have the "has_secure_password" the  password will be automatically encrypted and stored in password_digest field
  def create
    @user = User.create(user_params);
    if @user.valid?
      render :status=>201, json: { user: UserSerializer.new(@user) }, status: :created
    else
      render :status=>500, json: {
               error: 'Failed to create user',
             }
    end
  end

  #returns all user from the database and returs a json to the endpoint
  def users 
    @users=User.all;
    render :status =>200, json:  @users;
  end

  # Handles login process by finding the user in database with the email provided 
  def login
    user = User.find_by(email: user_params[:email]);
    if authenticate(user_params[:password],user[:password_digest]) #check if the hashed password from db is the same as the plain password provided by user
    render json: {:token=>encode_token(user), :user => {:id =>user[:id], :name => user[:name], :address=>user[:address], :email =>user[:email]}}
    else
      # If password is wrong or user is not found in the db
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
        JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def is_authorised?
    !!current_user
  end

  private
  # Returns a copy of the parameters object, returning only the permitted keys and valuesReceives of data send from the client
  def user_params
    params.require(:user).permit(:name, :address, :email, :password);
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
    return JWT.encode(payload, 'my_screte_key_#2022_api_#api_users') #JWT encording
  end
end
