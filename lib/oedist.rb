module Oedist
  require 'zmq'
  require 'syslog'
  
  def log(message)
    Syslog.open($0, Syslog::LOG_PID | Syslog::LOG_CONS) { |s| s.warning message }
  end

  def sendMsg(msg)
    context = ZMQ::Context.new
    begin
      toCoordinator = context.socket(ZMQ::DOWNSTREAM)
      toCoordinator.connect("tcp://*:12345")
      toCoordinator.send(msg)
      toCoordinator.close
    rescue => e
      log("AMUN - Error while sending message - #{msg} - to coordinator " + e.inspect)
    end
  end  

  def connect
    @context = ZMQ::Context.new
    @sender = @context.socket(ZMQ::DOWNSTREAM)
    @sender.connect("tcp://*:12345")
  end

  def msgsend(msg)
    @sender.send(msg)
  end

  def disconnect
    @sender.close
    @context.close
  end

protected

  def encrypt
  end

end
