qemu-system-aarch64  -name vm2 -nographic  \
  -enable-kvm -M virt -cpu host -smp 2 -m 4096 \
  -global virtio-blk-device.scsi=off \
  -device virtio-scsi-device,id=scsi \
  -kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477" \
  -initrd initramfs-4.18 \
 -drive file=vhuser-test1.qcow2  \
 -netdev user,id=unet,hostfwd=tcp:127.0.0.1:1122-:22 -device virtio-net-device,netdev=unet \
 -vnc :10
#./build/vhost-switch -l 0-3 -n 4 --huge-dir /dev/hugepages --socket-mem 1024 --log-level 8 -w 0000:07:00.1 -- --socket-file  /tmp/vhost-user1   --client -p 0x1 --stats 20
#-chardev socket,id=char0,path=/tmp/vhost-user1,server \
#-netdev type=vhost-user,id=netdev0,chardev=char0,vhostforce \
#-device virtio-net-pci,netdev=netdev0,mac=52:54:00:00:00:01,mrg_rxbuf=on,rx_queue_size=1024,tx_queue_size=1024 \
