class Api::V1::FoldersController < Api::V1::BaseController
    before_action :set_folder, only: %i[destroy]

    def index
        folders = current_user.folders.order(created_at: :desc)
        json_string = FolderSerializer.new(folders).serializable_hash.to_json
        render json: json_string
    end

    def create 
        folder = current_user.folders.build(folder_params)
        if folder.save
            json_string = FolderSerializer.new(folder).serializable_hash.to_json
            render json: json_string
        else
            render json: {errors: folder.errors.full_messages}, status: 400
        end
    end

    def destroy
        if @folder.destroy
            render json: {message: "Folder deleted successfully"}
        else
            render json: { error: "Failed to destroy" }, status: 422
        end
    end

    private 

    def set_folder
        @folder = current_user.folders.find(params[:id])
    end

    def folder_params
        params.require(:folder).permit(:name)
    end
end
