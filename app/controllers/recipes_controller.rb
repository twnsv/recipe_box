class RecipesController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@recipes = Recipe.all
	end

	def new
		@recipe = current_user.recipes.build
	end

	def create
		@recipe = current_user.recipes.build(recipe_params)

		if @recipe.save
			redirect_to @recipe, warning: "Successfully created new recipe"
		else
			render :new
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])

		if @recipe.update(recipe_params)
			redirect_to recipe_path(@recipe)
		else
			render :edit
		end
	end

	def show
		@recipe = Recipe.find(params[:id])	
	end

	def destroy
		@recipe = Recipe.find(params[:id])	
		@recipe.destroy
		redirect_to root_path, notice: "Successfully deleted recipe"
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :description, :image,
																	 ingredients_attributes: [:id, :name, :_destroy],
																	 directions_attributes: [:id, :step])
	end
end
