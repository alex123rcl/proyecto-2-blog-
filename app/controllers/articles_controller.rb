class ArticlesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
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
    @article = Article.find(params[:id])
    @comments = @article.comments.includes(:user)
  end
  
  
  def index
    @articles = Article.all
  end

  def edit
    @article = Article.find(params[:id])
  end 

  def update
    @article = Article.find(params[:id])  
    if @article.update(article_params)    
      redirect_to @article                
    else
      render 'edit'                       
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.user == current_user
      @article.destroy
      redirect_to articles_path, notice: 'borrado'
    else
      redirect_to articles_path, alert: 'sin permisos .'
    end
  end
  

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
