package "git"
package "wget"

git '/tmp/kueue' do
  repository node['deploy-kueue']['kueue-repository-uri']
  revision node['deploy-kueue']['kueue-repository-revision']
end

directory "/home/root/" do
  recursive true
end

file "/home/root/kueue" do
  content lazy { ::File.open("/tmp/kueue/kueue-distribution/src/dist/script/unix/kueue").read }
  mode "777"
  action :create
end

file "/home/root/kueue-install.sh" do
  content lazy { ::File.open("/tmp/kueue/kueue-distribution/src/dist/script/unix/kueue-install.sh").read }
  mode "777"
  action :create
end

file "/home/root/log4j.xml" do
  content lazy { ::File.open("/tmp/kueue/kueue-distribution/src/dist/script/unix/log4j.xml").read }
  mode "777"
  action :create
end

file "/home/root/upgrade-kueue.sh" do
  content lazy { ::File.open("/tmp/kueue/kueue-distribution/src/dist/script/unix/upgrade-kueue.sh").read }
  mode "777"
  action :create
end

execute "Run the deploy script:" do
  command "sudo /home/root/kueue-install.sh"
  cwd "/home/root/"
end

file "/data/kueue/log4j.xml" do
  content lazy { ::File.open("/home/root/log4j.xml").read }
  mode "777"
  action :create
end

service "kueue" do
  supports :status => false, :restart => false, :reload => false
  action [ :start ]
end


