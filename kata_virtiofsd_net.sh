qemu-system-aarch64 \
        -machine virt,usb=off,accel=kvm,gic-version=3,nvdimm -cpu host \
        -m 2048M,slots=10,maxmem=31976M \
        -object memory-backend-file,id=mem2,size=2048M,mem-path=/mnt/share -numa node,memdev=mem2\
        -device pcie-pci-bridge,bus=pcie.0,id=pcie-bridge-0,addr=2,romfile= \
        -device virtio-serial-pci,disable-modern=false,id=serial0,romfile= \
        -device virtconsole,chardev=charconsole0,id=console0 \
        -chardev socket,id=charconsole0,path=console.sock,server,nowait \
        -device virtio-scsi-pci,id=scsi0,disable-modern=false,romfile= \
        -object rng-random,id=rng0,filename=/dev/urandom \
        -device virtio-rng-pci,rng=rng0,romfile= \
        -chardev socket,id=charch0,path=kata.sock,server,nowait \
        -device virtserialport,chardev=charch0,id=channel0,name=agent.channel.0 \
        -vga none -no-user-config -nodefaults -nographic \
        -kernel vmlinux \
        -append "init=/bin/bash console=hvc0 console=hvc1 console=earlycon root=/dev/vda1 rootflags=data=ordered,errors=remount-ro ro rootfstype=ext4 debug systemd.show_status=true systemd.log_level=debug panic=1 nr_cpus=123 agent.use_vsock=false systemd.unit=kata-containers.target systemd.mask=systemd-networkd.service systemd.mask=systemd-networkd.socket scsi_mod.scan=none agent.log=debug agent.log=debug initcall_debug" \
 -smp 1,cores=1,threads=1,sockets=8,maxcpus=8 \
        -device virtio-blk-pci,disable-modern=false,drive=image-3da809c1d0297a2d,scsi=off,config-wce=off,romfile=,share-rw=on \
        -drive id=image-3da809c1d0297a2d,file=kata-containers.img,aio=threads,format=raw,if=none,readonly \
        -qmp unix:qmp.sock,server,nowait \
        -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs \
	 -netdev tap,ifname=tap1,id=network-0,vhost=on,script=no,downscript=no \
	         -device driver=virtio-net-pci,netdev=network-0,mac=02:42:ac:11:00:02,disable-modern=false,mq=on,vectors=4,romfile= \
##=============== bugs
##=============== bugs
#-object memory-backend-file,id=mem0,size=4096M,mem-path=/mnt/huge1 -numa node,memdev=mem0\
#virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/tmp/hostShare -o cache=always
#mount -t virtiofs myfs /mnt
# login and monitor
# socat "stdin,raw,echo=0,escape=0x11" "unix-connect:console.sock"
#-qmp unix:qmp.sock,server,nowait
#-qmp tcp:127.0.0.1:4444,server,nowait
# { "execute": "stop" }
#nc -U qmp.sock
#-object memory-backend-file,id=mem0,size=4096M,mem-path=/tmp/kata \
#-netdev tap,ifname=tap1,id=network-0,vhost=on,script=qemu-ifup,vnet_hdr=on \
#-device driver=virtio-net-pci,netdev=network-0,mac=02:42:ac:11:00:02,disable-modern=false,mq=on,vectors=4,romfile= \
#-netdev tap,id=network-0,vhost=on,vhostfds=3,fds=4 -device driver=virtio-net-pci,netdev=network-0,mac=32:26:5a:e7:0d:83,disable-modern=false,mq=on,vectors=4,romfile=
