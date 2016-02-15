class ArticlesController < ApplicationController


  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new 
    if not is_admin?
      render_forbidden
    end  

    @article = Article.new

  end

  def edit 

    if not is_admin?
      render_forbidden
    end

    @article = Article.find(params[:id])

  end

  def create

    if not is_admin?
      render_forbidden
    end

    @article = Article.new(article_params)
    result = @article.save
    if result
      redirect_to @article 
    else
      render 'new'
    end
  end

  def update

    if not is_admin?
      render_forbidden
    end

    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  
  end

  def destroy 

    if not is_admin?
      render_forbidden
    end

    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path

  end

  private 
    def article_params
      params.require(:article).permit(:title,:text)
    end

end
