class DirectorsController < ApplicationController
	helper_method :sort_column, :sort_direction

	def index
		#@directors = Director.all.sort_by { |d| d[:name].sub(/^the /i,"").downcase }
		@directors = Director.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
	end

	def new
	end

	def create
		Director.create(director_params);
		redirect_to directors_path
	end

	def edit
		@director = Director.find(params[:id])
	end

	def update
		Director.find(params[:id]).update!(director_params)
		redirect_to directors_path
	end

	def director_params
		params.require(:director).permit(:name)
	end

	def destroy
	    @director = Director.find(params[:id])
	    @director.destroy

	    redirect_to directors_path
	end

	private 

	def sort_column
		Director.column_names.include?(params[:sort]) ? params[:sort] : "name"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end
