class ArticlesController < ApplicationController

  $edit = false
  $show = false
  def new
    @article = Article.new
    $show=false
    $edit=false
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to @article }
        format.js   {}
      else
        format.js   {}
      end
    end
  end

  def index
    $show=true
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
    $edit = true
    $show=false
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

  def checkout
    Apayi.client_id = '2e18fd35-3315-4257-8865-9481f474806d'
    Apayi.secret_key = 'W+hjYq3YkUahW9PYsdQxAwK3s5fWvEkd6gcgIM6jx9l8FQEdqt97YWv59dYp2ndgctmRKXSQXAPfQlTWOBLycQ=='
    url = Apayi::Payment.checkout(article_params)
    redirect_to url.checkout_url
  end

  private
  def article_params
    params.require(:article).permit(:order_id, :amount, :currency, :user_email, :product_desc)
  end

end
