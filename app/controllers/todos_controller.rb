class TodosController < ApplicationController
            skip_before_action :verify_authenticity_token
            before_action :Task_id , only: [ :show , :update , :destroy]

        def index
        
            @Task_data = Todo.all.page params[:page]
            if @Task_data
                render json: @Task_data 
            else
                render json: {meassage: 'The database is empty.'}
            end
        end

        # def show
        #     if @Task_id_data
        #         render json: @Task_id_data
        #     else
        #         render json: {message: 'The id is not in the database or there is some mistake in the id.'}
        #     end
        # end

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
                if @Task_id_data.destroy(params_data)
                    render json: @Task_id_data 
                else
                    render json: {msg: 'The id not found'}
                end
            else
                render json: {msg: 'The Task_id_data is empty.'}
            end
        end

        private
            def params_data
                params.permit(:TaskName , :TaskDescription ,
                :status , :tags)
            end
            def Task_id
                if Todo.find(params[:id]).empty?
                    render json:{msg: 'The data with %id id is not available in the database'}
                else
                    @Task_id_data = Todo.find(params[:id])
                end
            end
end