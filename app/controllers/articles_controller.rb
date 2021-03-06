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
    # Apayi.client_id = '<client_id>'
    # Apayi.secret_key = '<secret_key>'
    # begin
    @article = Article.new(article_params)
    @article.save!
    #
    #   url = Apayi::Payment.checkout(article_params)
    #   if @article.send_email_check_box
    #     PaymentMailer.email_checkout_url(article_params[:user_email], url.checkout_url).deliver_now
    #   else
    #     redirect_to url.checkout_url
    #   end
    #
    # rescue Apayi::ApayiGenericError => err
    #   render :file => "/public/500.html",  :status => 500
    #   return
    # end

    redirect_to checkout_new_articles_path
  end

  def checkout_new
  end


  private
  def article_params
    params.require(:article).permit(:order_id, :amount, :currency, :user_email, :product_desc, :send_email_check_box)
  end

end
