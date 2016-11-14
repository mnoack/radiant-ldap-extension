Gem::Specification.new do |s|
  spec.name          = 'radiant-ldap-extension'
  spec.version       = '0.1.0'
  spec.authors       = ['Michael Noack']
  spec.email         = ['support@travellink.com.au']
  spec.description   = %q{Extension to allow login to admin via ldap.}
  spec.summary       = %q{Extension to allow login to admin via ldap.}
  spec.homepage      = 'http://github.com/sealink/radiant-ldap-extension'

  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.require_paths = %w[lib]

  spec.add_dependency 'net-ldap'
end
