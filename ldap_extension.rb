# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'
class LdapExtension < Radiant::Extension
  version "1.0"
  description "This extension allows ldap logins for admin"
  url ''


  def activate
    require 'ldap'
    User.class_eval do
      def authenticated_with_ldap?(password)
        authenticated_without_ldap?(password) || Ldap.authenticated?(login, password)
      end
      alias_method_chain :authenticated?, :ldap
    end
  end


  def deactivate
    # remove alias_method_chain otherwise stack level too deep
    # http://blog.jayfields.com/2008/04/alternatives-for-redefining-methods.html
    User.class_eval do
      alias_method :authenticated?, :authenticated_without_ldap?
    end
  end
end
