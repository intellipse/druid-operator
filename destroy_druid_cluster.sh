kubectl delete -f examples/prod-cluster.yaml
gcloud -q sql databases delete druid --instance=intellipse-metadata
kubectl delete pvc --all -n druid
gsutil -q rm -r gs://production-205919/druid
sleep 5
kubectl exec zookeeper-0 -n zookeeper zkCli.sh rmr /druid
