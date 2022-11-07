su -c  "echo "ubuntu ALL=(ALL) NOPASSWD:ALL">/etc/sudoers.d/ubuntu"
su -c "echo "ubuntu:x:1001:1001::/home/ubuntu:/bin/bash">/etc/passwd"
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
wget https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt-key add apt-key.gpg
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >/etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt install kubeadm=1.20.0-00 kubectl=1.20.0-00 kubelet=1.20.0-00 -y
kubeadm init
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
kubectl proxy --address '0.0.0.0' --port=8002 --accept-hosts='.*'
