# kubernetes-ansible-deployment
Deploy a production grade kubernetes cluster using terraform and ansible

_20230626 | César Bento Freire | <cesar.freire@training.rumos.pt>_


---
## AWS setup


__Create a aws account at__

https://aws.amazon.com/pt/

__Export Access keys__

Profile >> Security credentials >> Access keys

NOTE: Best practices suggests to create  new user with temporary access keys

---

## Local setup

### SSH Keys

__Create a ssh key if not exist__

        $ ssh-keygen

__Copy private and public keys to ansible folder__

        cp ~/.ssh/id_rsa* terraform/ansible

### Terraform setup

__Initialize terraform provider__

        $ terraform init

__Create a file `terraform.tfvars` and add your credentials__

```
# AWS Settings
# user: cfreire-aws-tf
aws_access_key = "AKIAxxxxxxxxxxxxxxxxx"
aws_secret_key = "Ssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
aws_region     = "eu-central-1"

```

__Apply terraform plan__

        $ terraform apply

## Using kubernetes cluster

```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

remote_login_controler = "ssh ubuntu@18.156.6.103 -i ubuntu-key-20220301.pem"
remote_login_instances = [
  "ssh ubuntu@52.59.255.105 -i ubuntu-key-20220301.pem",
]
```
__Access controller node__

        $ ssh ubuntu@<controller-public-ip> -i ubuntu-key-20220301.pem

__Generate new token__

        $ microk8s add-node

__Remote access worker nodes add token__

        $ ssh <ip-workers> -C "microk8s join 172.31.34.175:25000/b514d157dac75c62627a6bae27118385/fe4b50657a04"


```
The authenticity of host '54.93.74.32 (54.93.74.32)' can't be established.
ED25519 key fingerprint is SHA256:JpVHnLUCoAIgCfd01qm3QwpwLOK9L4GqkXwaC+D5mAM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '54.93.74.32' (ED25519) to the list of known hosts.
Contacting cluster at 172.31.39.141
Waiting for this node to finish joining the cluster. .. .. ..  `

```

__Verify cluster ok__

```
$ kubectl get node -o wide
NAME               STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
ip-172-31-34-175   Ready    <none>   15m   v1.27.2   172.31.34.175   <none>        Ubuntu 22.04.2 LTS   5.19.0-1027-aws   containerd://1.6.15
ip-172-31-38-117   Ready    <none>   49s   v1.27.2   172.31.38.117   <none>        Ubuntu 22.04.2 LTS   5.19.0-1027-aws   containerd://1.6.15

```
__Enable dashboard__

        $ microk8s enable dashboard

__Access the dashboard using the token retrieved with__

        $ microk8s kubectl describe secret -n kube-system microk8s-dashboard-token

__Goto controller node public ip on port 8443__

  $ microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 8443:443 --address 0.0.0.0

Ex.: https://35.159.49.78:8443 add add token

---
## Deploy demo application
https://discourse.ubuntu.com/t/install-a-local-kubernetes-with-microk8s/13981

    $ microk8s kubectl create deployment microbot --image=dontrebootme/microbot:v1
    $ microk8s kubectl scale deployment microbot --replicas=2

    $ microk8s kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

    $ microk8s kubectl port-forward -n default svc/microbot-service 8080:80 --address 0.0.0.0


## Deploy webcounter app

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redis
  name: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  strategy: {}
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - image: redis:alpine
        name: redis
        resources: {}
status: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: redis
  name: redis-service
  namespace: default
spec:
  ports:
  - port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    app: redis
  type: ClusterIP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: webcounter
  name: webcounter
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webcounter
  strategy: {}
  template:
    metadata:
      labels:
        app: webcounter
    spec:
      containers:
      - image: cfreire70/webcounter
        env:
        - name: REDIS_URL
          value: redis-service
        name: webcounter
        resources: {}
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: webcounter
  name: webcounter-service
  namespace: default
spec:
  ports:
  - port: 5000
    protocol: TCP
    targetPort: 5000
    nodePort: 31555
  selector:
    app: webcounter
  type: NodePort

```

