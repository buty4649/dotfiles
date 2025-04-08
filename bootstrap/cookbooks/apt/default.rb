need_update = -> do
  atime = run_command("stat --format=%Y /var/cache/apt/pkgcache.bin || true").stdout.chomp
  return true if atime.empty?

  Time.now.to_i - atime.to_i < 24 * 3600
end.call

execute 'apt-get update' do
  command 'sudo apt-get update'
  only_if { need_update }
end

execute 'apt-get upgrade' do
  command 'sudo apt-get upgrade -y'
  only_if { need_update }
end
