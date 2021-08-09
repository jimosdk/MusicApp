class NotesController < ApplicationController
    before_action :require_current_user ,only: [:create]
    before_action :require_author_or_admin ,only: [:destroy]

    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.save
        redirect_to track_url(@note.track)
    end

    def destroy
        @note = Note.find_by(id: params[:id])
        track = @note.track 
        @note.destroy 
        redirect_to track_url(track)
    end

    private

    def note_params
        params.require(:note).permit(:track_id,:description)
    end

    def require_author_or_admin
        note = Note.find_by(id: params[:id])
        render plain: "Note can only be deleted by author or admin",status: :forbidden unless current_user && current_user.id == note.user_id || admin?
    end

end