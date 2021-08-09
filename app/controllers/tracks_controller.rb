class TracksController < ApplicationController
    before_action :require_current_user
    before_action :require_admin, except: [:show]

    def new
        @track = Track.new
        @track.album_id = params[:album_id]
        render :new
    end

    def create
        @track = Track.new(track_params)
        if @track.save
            redirect_to track_url(@track)
        else  
            flash.now[:errors] = @track.errors.full_messages
            render :new
        end
    end

    def show 
        @track = Track.find_by(id: params[:id])
        render :show
    end

    def edit
        @track = Track.find_by(id: params[:id])
        render :edit
    end

    def update  
        @track = Track.find_by(id: params[:id])
        if @track.update(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors] = @track.errors.full_messages 
            render :edit 
        end
    end

    def destroy  
        @track = Track.find_by(id: params[:id])
        album = @track.album 
        @track.destroy 
        redirect_to album_url(album)
    end

    private 

    def track_params
        params.require(:track).permit(:title,:ord,:lyrics,:album_id,:bonus)
    end
end