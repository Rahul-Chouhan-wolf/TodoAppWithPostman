class Todo
    include Mongoid::Document

    field :TaskName , type: String
    field :TaskDescription , type: String
    field :status , type: String
    field :tags , type: Array

    validates :TaskName , :TaskDescription ,
    :status , :tags , presence: {message: 'Must be given please.'}

    paginates_per 3

end