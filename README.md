# druid-operator 

druid-operator is a kubernetes operator for deploying Druid clusters. It is built using the [operator-sdk](https://github.com/operator-framework/operator-sdk/tree/v0.11.0) . 

# How to run druid-operator locally
```
druid-operator$ kubectl create -f deploy/service_account.yaml
# Setup RBAC
druid-operator$ kubectl create -f deploy/role.yaml
druid-operator$ kubectl create -f deploy/role_binding.yaml
# Setup the CRD
druid-operator$ kubectl create -f deploy/crds/druid.apache.org_druids_crd.yaml
# Run operator locally, by default operator shall look for current context in the kubeconfig
druid-operator$ operator-sdk up local
```

# How to build druid-operator docker image

Pre-built docker images are available in [DockerHub](https://hub.docker.com/r/druidio/druid-operator). You can build docker image from source code using the command below.

```
druid-operator$ docker build -t druidio/druid-operator:0.0.1 .
```

# Deploying druid-operator on kubernetes

```
# Setup Service Account
druid-operator$ kubectl create -f deploy/service_account.yaml
# Setup RBAC
druid-operator$ kubectl create -f deploy/role.yaml
druid-operator$ kubectl create -f deploy/role_binding.yaml
# Setup the CRD
druid-operator$ kubectl create -f deploy/crds/druid.apache.org_druids_crd.yaml

# Update the operator manifest to use the druid-operator image name (if you are performing these steps on OSX, see note below)
druid-operator$ sed -i 's|REPLACE_IMAGE|<druid-operator-image>|g' deploy/operator.yaml
# On OSX use:
druid-operator$ sed -i "" 's|REPLACE_IMAGE|<druid-operator-image>|g' deploy/operator.yaml

# Deploy the druid-operator
druid-operator$ kubectl create -f deploy/operator.yaml

# Check the deployed druid-operator
druid-operator$ kubectl describe deployment druid-operator
```

# Deploy Intellipse druid cluster

An example spec to deploy the prod druid cluster is included. For full details on spec please see `pkg/api/druid/v1alpha1/druid_types.go`

```
# deploy druid cluster spec
druid-operator$ kubectl apply -f examples/prod-cluster.yaml
```

# Debugging Problems

 - For kubernetes version 1.11 make sure to disable ```type: object``` in the CRD root spec. 

```
# get druid-operator pod name
druid-operator$ kubectl get po | grep druid-operator

# check druid-operator pod logs
druid-operator$ kubectl logs <druid-operator pod name>

# check the druid spec
druid-operator$ kubectl describe druids prod-cluster

#  check if druid cluster is deployed
druid-operator$ kubectl get svc | grep prod
druid-operator$ kubectl get cm | grep prod
druid-operator$ kubectl get sts | grep prod
```
