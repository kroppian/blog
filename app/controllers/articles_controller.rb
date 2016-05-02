class ArticlesController < ApplicationController

  before_action :check_autho, except: [:show, :index]

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new 
    @article = Article.new
  end

  def edit 
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    result = @article.save
    if result
      redirect_to @article 
    else
      render 'new'
    end
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
    @article.destroy
    redirect_to articles_path
  end

  private 
    def article_params
      params
        .require(:article)
        .permit(:title,:text)
        .merge(user: current_user)
    end

    def check_autho
      if not is_admin?
        render_forbidden
        return
      end
    end

end
