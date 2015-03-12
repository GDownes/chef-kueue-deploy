directory "/data/" do
	action :create
end

file '/data/test' do
  content 'hello world'
  action :create
end