# further read on https://aws.amazon.com/premiumsupport/knowledge-center/eks-pods-efs/
kubectl apply -f class.yaml
#kubectl apply -f configmap.yaml  --file.system.id=$FILE.SYSTEM.ID --aws.region$AWS.REGION
#kubectl apply -f rbac.yaml

kubectl apply -f pv-pvc.yaml