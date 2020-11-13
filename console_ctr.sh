#qemu-system-aarch64  -name vm2 -nographic  \
qemu-system-aarch64  -name vm2 -daemonize \
  -enable-kvm -M virt -cpu host -smp 2 -m 4096 \
  -object memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge,share=on \
  -numa node,memdev=mem -mem-prealloc \
  -global virtio-blk-device.scsi=off \
  -device virtio-scsi-device,id=scsi \
  -kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477 iommu=pt intel_iommu=on iommu.passthrough=1" \
  -initrd initramfs-4.18 \
 -drive file=vhuser-test1.qcow2  \
 -serial telnet:localhost:4321,server,nowait\
 -vnc :10
#./build/vhost-switch -l 0-3 -n 4 --huge-dir /dev/hugepages --socket-mem 1024 --log-level 8 -w 0000:07:00.1 -- --socket-file  /tmp/vhost-user1   --client -p 0x1 --stats 20
#./build/vhost-switch -l 0-3 -n 4 --huge-dir /mnt/huge --socket-mem 1024 --log-level 8 -w 0000:07:00.1 -- --socket-file  /tmp/vhost-user1   --client -p 0x1 --stats 20
#-netdev user,id=sshtap,hostfwd=tcp:127.0.0.1:1122-:22 -device virtio-net-device,netdev=sshtap \
#-net nic,macaddr=00:00:00:08:e8:aa,addr=1f \
#-net user,hostfwd=tcp:127.0.0.1:6002-:22 \
#-netdev user,id=unet,hostfwd=tcp:127.0.0.1:1122-:22 -device virtio-net-device,netdev=unet \
#-serial telnet:localhost:4321,server,nowait\
#-monitor telnet:localhost:4321,server,nowait\
