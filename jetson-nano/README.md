# Adding a Jetson Nano as worker node
## Requirements
- Jetson nano 2GB
- Micro SD
- USB C (Power)
- Mouse and Keyboard
- Monitor

## Installing the OS
- Follow [this instructions](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-2gb-devkit#write).
- Then [here](https://developer.nvidia.com/embedded/learn/get-started-jetson-nano-2gb-devkit#setup).
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