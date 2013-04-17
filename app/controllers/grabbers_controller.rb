require "open3"
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
      Open3.popen2e(@grabber.request_string) {|stdin, stdout_and_stderr, wait_thr|
        #log output
        $grabber_log.info "command: #{@grabber.request_string}"
        $grabber_log.info "result: #{stdout_and_stderr.readlines}"
      }
      msg = "Your Request has been submitted and you will be notified by email when it is ready. :) "
      flash[:notice] = "Your Request has been submitted and you will be notified by email when it is ready. :) "
      respond_to do |format|
        format.html {redirect_to root_url}
        format.json { render json: {:submit => "success", 'msg'=> msg}}
      end

    else
      respond_to do |format|
        format.html {render :action => 'new'}
        format.json {render json: {:submit => "success", 'errors' => @grabber.errors}}
      end

    end
  end
end