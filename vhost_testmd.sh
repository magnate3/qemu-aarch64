#qemu-system-aarch64  -name vm2 -nographic   \
#gdb  --args  qemu-system-aarch64   -name vm2 -daemonize \
qemu-system-aarch64   -name vm2 -daemonize \
  -enable-kvm -M virt   -cpu host -smp 4 -m 4096 \
  -object memory-backend-file,id=mem,size=4096M,mem-path=/mnt/huge,share=on \
  -numa node,memdev=mem -mem-prealloc \
  -global virtio-blk-device.scsi=off \
  -device virtio-scsi-device,id=scsi \
   -drive file=dpdk.qcow2  \
  -kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477 iommu=pt intel_iommu=on iommu.passthrough=1" \
  -initrd initramfs-4.18 \
  -serial telnet:localhost:4322,server,nowait \
  -monitor telnet:localhost:4321,server,nowait \
  -chardev socket,id=char0,path=/tmp/vhost1,server \
  -netdev type=vhost-user,id=netdev0,chardev=char0,vhostforce \
  -device virtio-net-pci,netdev=netdev0,mac=52:54:00:00:00:01,mrg_rxbuf=on,rx_queue_size=256,tx_queue_size=256 \
  -vnc :10
#**********************if host use vhost-switch, the guest will hangs in  dpdk-devbind -b vfio-pci 0000:00:01.0
#./build/vhost-switch -l 0-3 -n 4 --huge-dir /mnt/huge --socket-mem 1024 --log-level 8 -w 0000:01:00.1 -- --socket-file  /tmp/vhost-user1   --client -p 0x1 --stats 20
#*****************if host use testpmd, the test succeds
#./testpmd -l 2,4,6,8,10,12,14,16,18 --socket-mem 1024,1024 -n 4\
# --vdev 'net_vhost0,iface=/tmp/vhost1,queues=4,client=1,iommu-support=1'\
# -- --portmask=0x1 -i --rxd=512 --txd=512 --rxq=4 --txq=4 --nb-cores=8 --forward-mode=txonly
#-kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477 iommu=pt intel_iommu=on iommu.passthrough=1" \
#-kernel vmlinuz-4.18 --append "console=ttyAMA0  root=UUID=6a09973e-e8fd-4a6d-a8c0-1deb9556f477" \


######## guest
#mkdir -p /mnt/huge-2048
#modprobe  vfio enable_unsafe_noiommu_mode=1
#cat /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
#modprobe vfio-pci
#mount -t hugetlbfs nodev /mnt/huge-2048/ -o pagesize=2048kB
#echo 512 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
#dpdk-devbind -b vfio-pci 0000:00:01.0
#
#testpmd -l 0,1,2  --socket-mem 1024 -n 4 \
#    --proc-type auto --file-prefix pg -- \
#    --portmask=0x1 --forward-mode=macswap --port-topology=chained \
#    -i --rxq=1 --txq=1 \
#    --rxd=256 --txd=256 --nb-cores=2 --auto-start
######--disable-rss -i --rxq=1 --txq=1 \
#
#
#
