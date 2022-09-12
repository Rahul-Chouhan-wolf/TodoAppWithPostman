class TodosController < ApplicationController
            skip_before_action :verify_authenticity_token
            before_action :Task_id , only: [ :show , :update , :destroy , :undo_id]

        def index
            @Task_data = Todo.all.page params[:page]
            @pagination_ends = @Task_data.empty?
            if @pagination_ends === false
                render json: @Task_data 
            else
                render json: {meassage: 'The database was only upto this page.'}
            end
        end

        def show_all
            @show = Todo.where.not(visible: false)
            if @show
                render json: @show
            else
                render json: {msg: 'The database is empty.'}
            end
        end

        def undo_id
           Todo.find(params[:id]).update(visible: true)
           render json: {msg: 'Undo Done'}
        end

        def show
            
            if @Task_id_data.visible
                render json: @Task_id_data
            else
                render json: {message: 'The id is not in the database or there is some mistake in the id.'}
            end
        end

        def create
           
            @Task_create = Todo.create(params_data)
            if @Task_create.save()
                render json: @Task_create
            else
                render json: {message: 'The Task was not saved.'}
            end
        end

        def update
            if @Task_id_data
                if @Task_id_data.update(params_data)
                    render json: @Task_id_data 
                else
                    render json: {msg: 'The id not found'}
                end
            else
                render json: {msg: 'The Task_id_data is empty.'}
            end
        end

        def destroy
            if @Task_id_data
                
                if @Task_id_data
                    Todo.find(params[:id]).update(visible: false)
                    render json: {msg: 'The data was Deleted.'}
                else
                    render json: {msg: 'The id not found'}
                end
            else
                render json: {msg: 'The Task_id_data is empty.'}
            end
        end

        def find_by_tag
            @Task_tag = Todo.where(tags: params[:tags])
            if @Task_tag
                render json: @Task_tag
            else
                render json: {message: 'Please enter an appropriate tag.'}
            end
        end

        private
            def params_data
                params.permit(:TaskName , :TaskDescription ,
                :status , :tags => [])
            end
            def Task_id
                @Task_id_data = Todo.find(params[:id])
                # if Todo.find(params[:id]).empty?
                #     render json:{msg: 'The data with id is not available in the database'}
                # else
                #     @Task_id_data = Todo.find(params[:id])
                # end
            end
end