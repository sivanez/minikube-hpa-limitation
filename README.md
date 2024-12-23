1. Install minikube
2. Install docker
3. Install metric server
   - kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
4. Verify metric installation
   - kubectl get deployment metrics-server -n kube-system
5. Edit to allow insecuretls (not recommended for prod)
   kubectl -n kube-system edit deployment metrics-server
6. Restart metric-server
   kubectl rollout restart deployment metrics-server -n kube-system

7. Start minikube 
   - minikube start --cpus=4 --memory=8192 --driver=docker
8.Deploy the Kubernetes Resources 
  - terraform init
  - terraform apply
9. Terraform destroy
