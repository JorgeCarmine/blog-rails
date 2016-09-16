class ArticlesController < ApplicationController
	
	before_action :validate_user, except: [:show, :index]

	#GET /articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@article = Article.find(params[:id])
		@article.update_visits_count
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	#GET articles/:id/edit
	def edit
		@article = Article.find(params[:id])
	end

	#PUT /article
	def update
		@article = Article.find(params[:id])
		
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#DELETE /articles
	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		redirect_to articles_path
	end


	private

	def validate_user
		unless user_signed_in?
			redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
		end
		
	end

	def article_params
		params.require(:article).permit(:title, :body)	
	end

end