package 'git'
package 'java-1.7.0-openjdk.x86_64'
package 'java-1.7.0-openjdk-devel.x86_64'
package 'gcc'

git '/tmp/kueue' do
	repository "git://git.kana.com/git/kueue.git"
end

execute "Configure iptables" do
	command "iptables -I INPUT 1 -p tcp -m state --state NEW -m tcp --dport 9090 -j ACCEPT"
end

execute "Update iptables configuration" do
	command "/sbin/service iptables save"
end

directory "/data/kueue/" do
	recursive true
end

group "kueue"

user "kueue" do
	system true
	gid "kueue"
	home '/data/kueue'
end

remote_file "/data/kueue/commons-daemon-1.0.15-src.tar.gz" do
  source "http://mirror.ox.ac.uk/sites/rsync.apache.org//commons/daemon/source/commons-daemon-1.0.15-src.tar.gz"
end

execute "Unpack commons daemon" do
	command "tar -zxvf /data/kueue/commons-daemon-1.0.15-src.tar.gz -C /data/kueue/"
end

execute "Navigate to commons daemon directory and build" do
    command "cd /data/kueue/commons-daemon-1.0.15-src/src/native/unix && ./configure --with-java=/usr/lib/jvm/java && make"
end

remote_file "/data/kueue/kueue-standalone.jar" do
  source "http://mirror.ox.ac.uk/sites/rsync.apache.org//commons/daemon/source/commons-daemon-1.0.15-src.tar.gz"
end

directory "/var/log/kueue/" do
	recursive true
end

# execute "Add kueue service" do
#     command "/sbin/chkconfig --add kueue"
# end

# execute "Start kueue service" do
#     command "/sbin/chkconfig kueue on"
# end




