## First step

```shell
az account set --subscription "1e12321e-10cc-4ba1-af96-643b3ca05ace"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/1e12321e-10cc-4ba1-af96-643b3ca05ace"

# Set this to .zprofile

export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```

## Authenticate local kubectl with AKS
```shell
az aks get-credentials --resource-group sd2139-rg --name myAKSCluster
```

## Prometheus & Grafana
```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
help repo update
helm install prometheus prometheus-community/prometheus --namespace prometheus --set alertmanager.persistentVolume.storageClass="managed-premium" --set server.persistentVolume.storageClass="managed-premium"

kubectl get all -n prometheus
kubectl port-forward -n prometheus deploy/prometheus-server 8080:9090
```

```shell
helm install grafana grafana/grafana --namespace grafana --set persistence.storageClassName="default" --set persistence.enabled=true --set adminPassword='AKS!sAwesome' --values /Users/kietlyc/hometemp/nashtech-assignment/sd2139-msa/grafana.yaml --set service.type=LoadBalancer

export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "http://$ELB"
 kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## ACR & AKS
```shell
# Create new cluster
az aks create -n myAKSCluster -g myResourceGroup --attach-acr sd2139frontend
# Just update the cluster
az aks update -n myAKSCluster -g myResourceGroup --attach-acr sd2139frontend
```