class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)  
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
       @comments = @article.comments.includes(:user)
  end
  
  def index
    @articles = Article.all
  end

  def edit
   
  end 

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.user == current_user  # Solo el propietario del artículo puede destruirlo
      @article.destroy
      redirect_to articles_path, notice: 'Artículo borrado'
    else
      redirect_to articles_path, alert: 'No tienes permiso para realizar esta acción.'
    end
  end

  private

   def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
