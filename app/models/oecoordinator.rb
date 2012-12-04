class Oecoordinator < ActiveRecord::Base
  require 'securerandom'

  def self.taskexec(server,role,task,account,user)
    msg = Oemessenger.new
    uuid = SecureRandom.uuid
    Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Task #{task.serial}", :server_id => server.id )
    message = "server: #{server.serial}
task: #{task.serial}
type: script
ident: #{uuid}"
    msg.SendMessage(server.serial,message)
  end

  def self.roleexec(role,task,account,user)
    msg = Oemessenger.new
    uuid = SecureRandom.uuid
    e = Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Role #{role.serial}" )
    role.servers.each do |s|
      e.child ||= []
      uuid = SecureRandom.uuid
      Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Task #{task.serial}", :server_id => s.id )
      message = "server: #{s.serial}
task: #{task.serial}
type: script
ident: #{uuid}
metadata: role
role: #{role.serial}"
      msg.SendMessage(s.serial,message)
      e.child << uuid
      e.save
    end
    e.ident
  end

  def self.mydeployordered(deployment,account,user)
    msg = Oemessenger.new
    d = Deployment.find(deployment)
    uuid = SecureRandom.uuid
    e = Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Deployment #{d.serial}" )
    d.workflows.each do |w|
      myworkflow(deployment,w.id).each(:as => :hash) do |t|
        e.child ||= []
        uuid = SecureRandom.uuid
        serv = t["server"]
        task = t["task"]
        message = "server: #{serv}
task: #{task}
type: script
ident: #{uuid}
metadata: deployment
deployment: #{d.serial}"
        msg.SendMessage(t["server"],message)
        ta = t["task"]
        Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Task #{ta}", :server_id => t["sid"] )
        e.child << uuid
        e.save
      end
    end
    e.ident
  end

  def self.myworkflowordered(deployment, workflow, account, user)
    msg = Oemessenger.new
    w = Workflow.find(workflow)
    d = Deployment.find(deployment)
    uuid = SecureRandom.uuid
    e = Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Workflow #{w.serial}" )
    myworkflow(deployment,workflow).each(:as => :hash) do |t|
      e.child ||= []
      ta = t["task"]
      uuid = SecureRandom.uuid
      serv = t["server"]
      task = t["task"]
      message = "server: #{serv}
task: #{task}
type: script
ident: #{uuid}
metadata: deployment
deployment: #{d.serial}"
      msg.SendMessage(t["server"],message)
      Event.create(:status => 4, :account_id => account, :user => user, :ident => uuid, :description => "Executing Task #{ta}", :server_id => t["sid"] )
      e.child << uuid
      e.save
    end
    e.ident
  end

protected
  def self.mydeploy(deployment)
    self.connection.execute(sanitize_sql(["select D.name as deploy, W.name as flow, S.serial as server, S.id as sid, R.name as role, RT.serial as task from deployments as D inner join servers as S inner join deployments_servers as DS inner join roles as R inner join roles_servers as RS inner join workflows as W inner join roletasks as RT inner join roletask_workflows as RW where D.id = DS.deployment_id and S.id = DS.server_id and R.id = RS.role_id and S.id = RS.server_id and D.id = W.deployment_id and RT.id = RW.roletask_id and W.id = RW.workflow_id and R.id = RT.role_id and D.id = ?",deployment]))
  end

  def self.myworkflow(deployment, workflow)
    self.connection.execute(sanitize_sql(["select D.name as deploy, W.name as flow, S.serial as server, S.id as sid, R.name as role, RT.serial as task from deployments as D inner join servers as S inner join deployments_servers as DS inner join roles as R inner join roles_servers as RS inner join workflows as W inner join roletasks as RT inner join roletask_workflows as RW where D.id = DS.deployment_id and S.id = DS.server_id and R.id = RS.role_id and S.id = RS.server_id and D.id = W.deployment_id and RT.id = RW.roletask_id and W.id = RW.workflow_id and R.id = RT.role_id and D.id = ? and W.id = ? ",deployment, workflow]))
  end
  
end
