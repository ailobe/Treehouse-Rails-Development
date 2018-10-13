class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:edit, :update, :destroy]


    def create
        @comment = @post.comments.create(comment_params)
        redirect_to @post
    end

    def edit
    end

    def update
        @comment.update(comment_params)
        redirect_to @post
    end

    def destroy
        @comment.destroy
        redirect_to @post
    end

    private
        def comment_params
            params.require(:comment).permit(:name,:content)
        end

        def set_post
            @post = Post.find(params[:post_id])
        end

        def set_comment
            @comment = Comment.find(params[:id])
        end
end
