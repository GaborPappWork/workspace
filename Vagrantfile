Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-16.04"
	
	config.vm.define "workspace" do |workspace|
		workspace.vm.provision "shell", path: "provision-workspace.sh"
		    workspace.vm.network "private_network", ip: "192.168.33.30"
		
		workspace.vm.provider "virtualbox" do |vb|
		  vb.customize ["modifyvm", :id, "--cpus", "2", "--memory", "4096", "--accelerate3d", "on", "--accelerate2dvideo", "on", "--vram", "256"]
		  vb.gui = true
		end
	end
end
