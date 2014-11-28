require 'rubygems'

Gem::Specification.new do |spec|
  spec.name      = 'windows-cng'
  spec.version   = '0.0.1'
  spec.author    = 'Daniel J. Berger'
  spec.license   = 'Artistic 2.0'
  spec.email     = 'djberg96@gmail.com'
  spec.homepage  = 'http://github.com/djberg96/windows-cng'
  spec.summary   = 'A Ruby interface to the next gen Windows crypto library'
  spec.test_file = 'test/test_windows_cng.rb'
  spec.files     = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']

  spec.add_dependency('ffi')

  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit')

  spec.description = <<-EOF
    The windows-cng library is a wrapper for the next generation Windows
    cryptography API.
  EOF
end
