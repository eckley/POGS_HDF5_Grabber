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
      #TODO send request, use pid = Process.spawn("cmd") and Process.detach(pid)
      ##  Process.spawn("python", "extract_from_hdf5.py", @grabber.galaxy, @grabber.feature, @grabber.layer, '-0 '  )
      #   Process.detach
      #
      ##  Or if ssh is required see http://johanharjono.com/archives/602
      flash[:notice] = "Request sent!"
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