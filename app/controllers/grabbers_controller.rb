class GrabbersController < ApplicationController
  def new
    @grabber = Grabber.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grabber }
    end
  end

  def create
    @grabber = Grabber.new(params[:grabber])
    if @grabber.valid?

     #run command
      result = IO.popen(@grabber.request_string)
      #log output
      $grabber_log.info result.readlines
      flash[:notice] = result.readlines
      respond_to do |format|
        format.html {redirect_to root_url}
        format.json { render json: {:submit => "success"}}
      end

    else
      respond_to do |format|
        format.html {render :action => 'new'}
        format.json { render json: @grabber }
      end

    end
  end
end