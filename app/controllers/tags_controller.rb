class TagsController < ApplicationController
	helper_method :sort_column, :sort_direction

	def index
		@tags = Tag.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
	end

	def new
	end

	def create
		Tag.create(tag_params);
		redirect_to tags_path
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		Tag.find(params[:id]).update!(tag_params)
		redirect_to tags_path
	end

	def tag_params
		params.require(:tag).permit(:tag_name)
	end

	def destroy
	    @tag = Tag.find(params[:id])
	    @tag.destroy

	    redirect_to tags_path
	end

	def search
		tags = Tag.where("tag_name LIKE ?", "#{params[:str]}%").order('tag_name ASC').limit(5).map{ |t| [t.tag_name, t.id] }
		render json: {success: true, data: tags}
	end

	private 

	def sort_column
		Tag.column_names.include?(params[:sort]) ? params[:sort] : "tag_name"
	end

	def sort_direction
		%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end
