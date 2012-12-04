class Oeldap
  require 'ldap'
  def initialize
    @lserver = LDAP::Conn.new('dbint.zuncloud.com',389)
  end
  def addEntry(rdn,ent)
    @lserver.bind('cn=Manager,dc=zuncloud,dc=com','zuncloud') do
    @lserver.add(rdn,ent)
    end
  end
  def deleteEntry(rdn)
    @lserver.bind('cn=Manager,dc=zuncloud,dc=com','zuncloud') do
    @lserver.delete(rdn)
    end
  end
  def updateEntry(rdn,ent)
    @lserver.bind('cn=Manager,dc=zuncloud,dc=com','zuncloud') do
    @lserver.modify(rdn,ent)
    end
  end
  def searchEntry()
    @lserver.bind('cn=Manager,dc=zuncloud,dc=com','zuncloud') do
    end
  end
  def createPuppetEntry(fqdn,serverp)
    entry = [ LDAP.mod(LDAP::LDAP_MOD_ADD, 'objectclass', ['top','device','puppetClient']), LDAP.mod(LDAP::LDAP_MOD_ADD, 'cn', [fqdn]), LDAP.mod(LDAP::LDAP_MOD_ADD, 'puppetClass', [serverp]) ]
    dn = "cn=" + fqdn.to_s + ",ou=Pclients,dc=zuncloud,dc=com"
    return self.addEntry(dn,entry)
  end
  def deletePuppetEntry(fqdn)
    dn = "cn=" + fqdn.to_s + ",ou=Pclients,dc=zuncloud,dc=com"
    return self.deleteEntry(dn)
  end
  def updatePuppetEntry(fqdn,serverp)
    entry = [ LDAP.mod(LDAP::LDAP_MOD_REPLACE, 'puppetClass', [serverp] ) ]
    dn = "cn=" + fqdn.to_s + ",ou=Pclients,dc=zuncloud,dc=com"
    return self.updateEntry(dn,entry)
  end
end
