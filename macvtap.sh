qemu-system-aarch64  -name vm2 -nographic  \
  -enable-kvm -M virt,usb=off -cpu host -smp 2 -m 4096 \
  -global virtio-blk-device.scsi=off \
  -device virtio-scsi-device,id=scsi \
  -kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477" \
  -initrd initramfs-4.18 \
 -drive file=vhuser-test1.qcow2  \
 -serial telnet:localhost:4322,server,nowait \
 -netdev tap,fd=30,id=hostnet0,vhost=on,vhostfd=4 30<>/dev/tap471 4<>/dev/vhost-net \
 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=1a:46:0b:ca:bc:7b
 #-netdev tap,id=network-0,vhost=on,vhostfds=3,fds=4 -device driver=virtio-net-pci,netdev=network-0,mac=1a:46:0b:ca:bc:7b,disable-modern=false,mq=on,vectors=4,romfile=
 #-device usb-ehci -device usb-kbd -device usb-mouse -usb\
 #-device usb-mouse,id=input0,bus=usb1,port=1 -device usb-kbd,id=input1,bus=usb.1,port=2
#./build/vhost-switch -l 0-3 -n 4 --huge-dir /dev/hugepages --socket-mem 1024 --log-level 8 -w 0000:07:00.1 -- --socket-file  /tmp/vhost-user1   --client -p 0x1 --stats 20
#-chardev socket,id=char0,path=/tmp/vhost-user1,server \
#-netdev type=vhost-user,id=netdev0,chardev=char0,vhostforce \
#-device virtio-net-pci,netdev=netdev0,mac=52:54:00:00:00:01,mrg_rxbuf=on,rx_queue_size=1024,tx_queue_size=1024 \
#-object input-linux,id=kbd1,evdev=/dev/input/event1,grab_all=on,repeat=on\
# -object input-linux,id=mouse1,evdev=/dev/input/event2 \
#-object input-linux,id=mouse1,evdev=/dev/input/event2 \
#-object input-linux,id=kbd1,evdev=/dev/input/by-id/usb-12d1_Keyboard_Mouse_KVM_1.1.0-event-kbd,grab_all=on,repeat=on\
#-device  -device usb-kbd -device usb-mouse -usb\
 #-usb -device ich9-usb-uhci1 \
 #-usb -device ich9-usb-uhci1
 #-device usb-host,hostbus=1,hostaddr=3
 #-device usb-host,vendorid=0x12d1,productid=0x0003a\
 #-device usb-tablet,id=input0,bus=usb.0,port=1 \
# -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2
## way
# -device piix3-usb-uhci,id=usb\
# -device usb-host,hostbus=1,hostaddr=3
 #-device usb-tablet,id=input0,bus=usb.003,port=1
 #-object input-linux,id=mouse1,evdev=/dev/input/mouse0\
 #-object input-linux,id=mouse2,evdev=/dev/input/event1\
 #-object input-linux,id=mouse3,evdev=/dev/input/event2\
