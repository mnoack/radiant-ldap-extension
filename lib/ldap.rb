require 'rubygems'
require 'net/ldap'
class Ldap
  def self.retrieve_from_ldap(login)
    filter = Net::LDAP::Filter.eq('samaccountname', login)
    ldap = load_ldap
    ldap.search(:filter => filter).first
  end

  def self.config
    yaml_file = "#{Rails.root}/config/ldap.yml"
    YAML::load(File.read(yaml_file))[Rails.env].symbolize_keys
  end

  def self.load_ldap
    auth = {:method => config[:method], :username =>  config[:username], :password =>  config[:password] }
    Net::LDAP.new  :host => config[:host], :port => config[:port], :base => config[:base], :auth => auth
  end

  def self.authenticated?(login, password)
    return false if password.blank?
    ldap = load_ldap
    ldap_entry = retrieve_from_ldap(login)
    dn=ldap_entry.dn
    ldap.auth(dn,password)
    ldap.bind
  end

  def self.ldap_users
    filter = Net::LDAP::Filter.eq(config[:filter_attr], config[:filter_value] )
    ldap = load_ldap
    ldap.search(:filter => filter).reject{|u| u[:samaccountname] == []}
  end

  def self.ldap_email(ldap_cn)
    filter = Net::LDAP::Filter.eq('samaccountname', ldap_cn)
    ldap = load_ldap
    ldap_entry = ldap.search(:filter => filter).first
    ldap_entry[:mail].to_s || ldap_entry[:userprincipalname].to_s
  end
end
