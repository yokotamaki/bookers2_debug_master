class SearchsController < ApplicationController
  
  def search
    @model = params[:model]
    search = params[:search]
    @keyword = params[:keyword]
    if @model == "1"
      @user = User.search(search,@keyword)
    else
      @book = Book.search(search,@keyword)
    end
  end

end
