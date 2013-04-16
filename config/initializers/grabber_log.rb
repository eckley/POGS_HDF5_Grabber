#creates a custom logger
class GrabberLog < Logger
  def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end

#setup custom logfile
grabber_logfile = File.open(Rails.root.join('log','grabber.log').to_s, 'a')
grabber_logfile.sync = true
$grabber_log = GrabberLog.new(grabber_logfile)