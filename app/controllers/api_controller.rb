class ApiController < ApplicationController
  before_action :check_user, except: %i[createUser login]

  def createUser
    unless params[:email].match(/\A[^@\s]+@[^@\s]+\z/)
      render json: { message: "Email Invalido" }, status: 400
      return
    end

    user = User.where(email: params[:email]).first

    unless user.nil?
      render json: { message: "Já existe conta com esse email"  }, status: 400
      return
    end

    if params[:password].length < 6
      render json: { message: "Password deve ter no minimo 6 caracteres"  }, status: 400
      return
    end

    u = User.new
    u.name = params[:name]
    u.email = params[:email]
    u.password = Cryptography.encrypt_pass(params[:password])

    if u.save
      render json: { message: "Usuario criado. Faça o login" }
    else
      render json: { message: "Verifique seus dados e tente Novamente" }, status: 400
    end
  end

  def login
    
    unless params[:email].match(/\A[^@\s]+@[^@\s]+\z/)
      render json: { message: "Email Invalido" }, status: 400
      return
    end
    if params[:password].blank?
      render json: { message: "Senha precisa estar presente" }, status: 400
      return
    end

    user = User.where(email: params[:email]).first

    if user.nil?
      render json: { message: "Usuário não existe" }, status: 400
      return
    end

    if params[:password] == Cryptography.decrypt_pass(user.password)
      sign_in user
      render json: { message: "Bem vindo" }
    else
      render json: { message: "Senha Incorreta" }, status: 400
    end
  end

  def check_user
    if current_user.nil?
      render json: { message: "Faça o login" }, status: 400
    end
  end

  def sign_out
    signOut
    render json: { message: "Faça o login" }, status: 400
  end
end
