VHOST_SOCK_DIR=/var/run/openvswitch/
#strace -fe trace=file qemu-system-aarch64  -name vm2 -nographic  \
qemu-system-aarch64  -name vm2 -nographic  \
  -enable-kvm -M virt,usb=off -cpu host -smp 2 -m 4096 \
  -global virtio-blk-device.scsi=off \
  -device virtio-scsi-device,id=scsi \
  -kernel vmlinuz-4.18 --append "/lib/systemd/systemd console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477" \
  -initrd initramfs-4.18 \
  -drive file=vhuser-test1.qcow2  \
  -m 2048M -numa node,memdev=mem -mem-prealloc \
  -object memory-backend-file,id=mem,size=2048M,mem-path=/dev/hugepages,share=on \
  -chardev socket,id=char1,path=$VHOST_SOCK_DIR/vhost-user1 \
  -netdev type=vhost-user,id=mynet1,chardev=char1,vhostforce \
  -device virtio-net-pci,netdev=mynet1,mac=00:00:00:00:00:01,mrg_rxbuf=off \
