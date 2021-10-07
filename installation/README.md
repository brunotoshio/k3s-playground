# Installation

## Requirements
- Raspberry Pi
- Micro SD card
- USB C (power)
- Ethernet cable (optional)
- A computer to setup the image

## OS install
- Download the [Raspberry Pi Imager ](https://www.raspberrypi.com/software/).
- Choose the OS `Raspberry Pi OS 32-bit`
- Connect the micro SD and write the OS image.
- Create an empty file named `ssh` and save it in the root of the SD card. This will enable headless configuration through SSH.
- Configure wifi (if necessary) by adding a file named `wpa_supplicant.conf` in the root of the SD card with the following contents:
    ```
    country=JP
    ctrl_interface=DIR=/var/run/wpa_supplicant 
    GROUP=netdev
    update_config=1

    network={
        scan_ssid=1
        ssid=WIFI_SSID
        psk=WIFI_PASSWORD
    }
    ```
- Insert the micro SD in Raspberry Pi and power it.

## Setup k3s
- Connect to Raspberry pi through SSH:
    ```
    ssh pi@raspberrypi.local
    ```
- Default password is `raspberry`.
- Configure Raspberry pi using:
    ```
    sudo raspi-config
    ```
- Set the `Hostname` (`System options` > `Hostname`)
- Setup the requirements for k3s:
    - Required `iptables`
    ```
    sudo iptables -F
    sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
    sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
    sudo reboot
    ```
    - Enable `cgroups` by appending `cgroup_memory=1 cgroup_enable=memory` to the file `/boot/cmdline.txt`
- Install k3s:
    ```
    curl -sfL https://get.k3s.io | sh -
    ```
- It took me over two minutes to finish the setup
- You can confirm the installation:
    ```
    sudo kubectl get nodes
    ```

## Static IP Address
- Setting a static ip address for the master node will help when connecting worker nodes.
- Modify `dhcpd.conf`:
    ```
    sudo nano /etc/dhcpcd.conf
    ```
    - Modify the lines to set the static ip address
        ```
        interface <NETWORK>
        static ip_address=<STATICIP>/24
        static routers=<ROUTERIP>
        static domain_name_servers=<DNSIP>
        ```
- Reboot
    ```
    sudo reboot
    ```
- Reserve the ip address in the router

## Add worker nodes
- Follow the same steps from the master node up to installing k3s.
- Install k3s with the command:
    ```
    sudo curl -sfL https://get.k3s.io | K3S_URL=https://MASTER_NODE_IP:6443 K3S_TOKEN=MASTER_NODE_TOKEN sh -
    ```
    - To obtain the master node token, access the master node and:
        ```
        sudo cat /var/lib/rancher/k3s/server/node-token
        ```
- To confirm the worker node, access the master node and:
    ```
    sudo kubectl get nodes
    ```