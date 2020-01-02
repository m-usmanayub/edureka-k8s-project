# further read on https://aws.amazon.com/premiumsupport/knowledge-center/eks-pods-efs/
kubectl apply -f ./pv/class.yaml
#kubectl apply -f configmap.yaml  --file.system.id=$FILE.SYSTEM.ID --aws.region$AWS.REGION
#kubectl apply -f rbac.yaml
export file_system_id=$(aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text)
envsubst < ./pv/pv-pvc.yaml | kubectl apply -f -