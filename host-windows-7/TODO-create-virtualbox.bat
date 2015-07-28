REM virtualbox name: PLUTO
REM os type: Ubuntu
REM ISO file path: C:\Users\ajstyles\Downloads\ubuntu-15.04-server-i386.iso

REM Public Network vboxnet0 (172.16.0.0/16)
VBoxManage hostonlyif create
VBoxManage hostonlyif ipconfig vboxnet0 --ip 172.16.0.254 --netmask 255.255.0.0

REM Private Network vboxnet1 (10.0.0.0/8)
VBoxManage hostonlyif create
VBoxManage hostonlyif ipconfig vboxnet1 --ip 10.0.0.254 --netmask 255.0.0.0





REM Create VirtualBox Machine
VBoxManage createvm --name PLUTO --ostype Ubuntu --register
VBoxManage modifyvm PLUTO --memory 2048 --nic1 nat --nic2 hostonly --hostonlyadapter2 vboxnet0 --nic3 hostonly --hostonlyadapter3 vboxnet1


REM Create CD-Drive and Attach ISO
VBoxManage storagectl PLUTO --name "IDE Controller" --add ide --controller PIIX4 --hostiocache on --bootable on
VBoxManage storageattach PLUTO --storagectl "IDE Controller" --type dvddrive --port 0 --device 0 --medium C:\Users\ajstyles\Downloads\ubuntu-15.04-server-i386.iso



REM Create and attach SATA Interface and Hard Drive
VBoxManage storagectl PLUTO --name "SATA Controller" --add sata --controller IntelAHCI --hostiocache on --bootable on
VBoxManage createhd --filename PLUTO.vdi --size 20480
VBoxManage storageattach PLUTO --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium PLUTO.vdi



VBoxManage startvm PLUTO --type gui

