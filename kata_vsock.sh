./qemu-system-aarch64 -nographic\
        -machine virt,usb=off,accel=kvm,gic-version=3,nvdimm -cpu host \
        -m 2048M,slots=10,maxmem=31976M \
        -device vhost-vsock-pci,disable-modern=false,id=vsock-1072880509,guest-cid=3,romfile= \
        -device pcie-pci-bridge,bus=pcie.0,id=pcie-bridge-0,addr=2,romfile= \
        -device virtio-serial-pci,disable-modern=false,id=serial0,romfile= \
        -device virtconsole,chardev=charconsole0,id=console0 \
        -chardev socket,id=charconsole0,path=console.sock,server,nowait \
        -device virtio-scsi-pci,id=scsi0,disable-modern=false,romfile= \
        -object memory-backend-file,id=mem0,size=4096M,mem-path=/tmp/kata \
        -object rng-random,id=rng0,filename=/dev/urandom \
        -device virtio-rng-pci,rng=rng0,romfile= \
        -chardev socket,id=charch0,path=kata.sock,server,nowait \
        -device virtserialport,chardev=charch0,id=channel0,name=agent.channel.0 \
        -kernel vmlinuz-5.4.60-89 \
        -append "init=/bin/bash console=hvc0 console=hvc1 console=earlycon root=/dev/vda1 rootflags=data=ordered,errors=remount-ro ro rootfstype=ext4 debug systemd.show_status=true systemd.log_level=debug panic=1 nr_cpus=123 agent.use_vsock=false systemd.unit=kata-containers.target systemd.mask=systemd-networkd.service systemd.mask=systemd-networkd.socket scsi_mod.scan=none agent.log=debug agent.log=debug initcall_debug" \
        -vga none -no-user-config -nodefaults -nographic \
       	-smp 1,cores=1,threads=1,sockets=123,maxcpus=123 \
        -device virtio-blk-pci,disable-modern=false,drive=image-3da809c1d0297a2d,scsi=off,config-wce=off,romfile=,share-rw=on \
        -drive id=image-3da809c1d0297a2d,file=kata-containers.img,aio=threads,format=raw,if=none,readonly \
        -device virtio-9p-pci,disable-modern=false,fsdev=extra-9p-kataShared,mount_tag=kataShared,romfile= \
        -fsdev local,id=extra-9p-kataShared,path=rootfs,security_model=none \
        -device virtio-9p-pci,disable-modern=false,fsdev=fsdev0,mount_tag=label1,romfile= \
        -fsdev local,id=fsdev0,path=share1,security_model=none \
	-serial telnet:localhost:4321,server,nowait\



       #-append "init=/bin/bash console=hvc0 console=hvc1 console=earlycon root=/dev/vda1 rootflags=data=ordered,errors=remount-ro ro rootfstype=ext4 debug systemd.show_status=true systemd.log_level=debug panic=1 nr_cpus=123 agent.use_vsock=false systemd.unit=kata-containers.target systemd.mask=systemd-networkd.service systemd.mask=systemd-networkd.socket scsi_mod.scan=none agent.log=debug agent.log=debug initcall_debug" \
	
#-drive id=image-3da809c1d0297a2d,file=kata-containers-ubuntu-latest.img,aio=threads,format=raw,if=none,readonly \
#-device nvdimm,id=nv0,memdev=mem0 \
#-device virtio-9p-pci,disable-modern=false,fsdev=extra-9p-kataShared,mount_tag=kataShared,romfile= \
#-fsdev local,id=extra-9p-kataShared,path=rootfs,security_model=none \
        #-netdev tap,ifname=tap1,id=network-0,vhost=on,script=no,downscript=no \
        #-device driver=virtio-net-pci,netdev=network-0,mac=02:42:ac:11:00:02,disable-modern=false,mq=on,vectors=4,romfile= \

# socat "stdin,raw,echo=0,escape=0x11" "unix-connect:console.sock"
#-device vhost-vsock-pci,disable-modern=false,vhostfd=3,id=vsock-1072880509,guest-cid=1072880509
#qemu-system-aarch64: -device nvdimm,id=nv0,memdev=mem0: memory hotplug is not enabled: missing acpi-ged device
#-device nvdimm,id=nv0,memdev=mem0 \
