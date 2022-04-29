class LibraryController < ApiController
  def create
    library = Library.new

    library.title = params[:title]
    library.author = params[:author]
    library.gender = params[:gender]
    library.read = params[:read]
    library.note = params[:note]
    library.review = params[:review]
    library.user = current_user.email

    if library.save
      render json: { message: "Livro Adicionado com sucesso" }
    else
      render json: { message: "Verifique seus dados e tente Novamente" }, status: 400
    end
  end

  def findAll
    books = Library.where(user: current_user.email)

    if books.nil?
      render json: { message: "Nenhum Livro" }
      return
    end

    render json: { content: books }
  end

  def search
    if params[:author].blank? && params[:gender].blank? && params[:title].blank?
      render json: { message: "Nenhuma especificação de busca" }, status: 400
      return
    end
    byebug
    books = Library.where(user: current_user.email)

    if params[:author].present?
      books = books.select { |book| book.author.downcase == params[:author].downcase }
    end

    if params[:gender].present?
      books = books.select { |book| book.gender.downcase == params[:gender].downcase }
    end

    if params[:title].present?
      books = books.select { |book| book.title.downcase == params[:title].downcase }
    end

    render json: { content: books }
  end
end