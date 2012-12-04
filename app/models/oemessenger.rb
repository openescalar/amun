class Oemessenger
  require 'stomp'
  require 'yaml'
  def initialize
    config = YAML.load_file("config/queue.yaml")
    @user = config["user"]
    @pass = config["password"]
    @host = config["host"]
    @port = config["port"]
    @dest = config["queue"]
    @opts = { 'persistent' => 'false' }
  end
#  def SendMessage(server, roletask, etype, ident)
#    message = "server: #{server}
#task: #{roletask}
#type: #{etype}
#ident: #{ident}"
    def SendMessage(server, message)
    @opts = { 'persistent' => 'false', 'client-id' => server }
    connection = Stomp::Connection.open(@user,@pass,@host,@port)
    connection.publish @dest, message, @opts
    connection.disconnect
  end
end
