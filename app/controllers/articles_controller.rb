class ArticlesController < ApplicationController


  def show
    @article = Article.find(params[:id])
  end

  def index
    printf "Hello world!"
    @articles = Article.all
  end

  def new 
    if is_admin?
      @article = Article.new
    else
      @articles = Article.all
      render 'index'
    end  

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
      params.require(:article).permit(:title,:text)
    end

end
