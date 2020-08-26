kubectl delete -f examples/prod-cluster.yaml
kubectl exec zookeeper-0 -n zookeeper zkCli.sh rmr /druid
gcloud sql databases delete druid --instance=intellipse-metadata
kubectl delete pvc --all -n druid
