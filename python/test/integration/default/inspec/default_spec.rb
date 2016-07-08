

describe command('/usr/local/bin/python3 --version') do
  its('stdout') { should match(/3\.4\.4/) }
end

describe command('/usr/local/bin/pip3 --version') do
  its('stdout') { should match(/7\.1\.2/)}
end
