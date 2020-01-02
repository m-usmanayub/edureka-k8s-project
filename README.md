# Deployment of K8s application with Ingress om AWS EKS with NFS Volume (EFS on AWS)

### An assignment from Edureka
### Reference documentation

1. Create EKS Cluster using eksctl
    >   Getting started with eksctl: [click here](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)
    >
    >   eksctl Reference Documentation: [click here](https://eksctl.io/usage/creating-and-managing-clusters/)

2. Create an Ingress Controller with AWS.

   >    For step by step help: [click here](https://kubernetes.github.io/ingress-nginx/deploy/)
   >
   >    Reference Documentation: [click here](https://kubernetes.io/docs/concepts/services-networking/ingress/)
   >
   >    GitHub Repo: [click here](https://github.com/kubernetes/ingress-nginx)

3. Create an EFS on AWS so that database can be made persist on it.

   >    EKS EFS CSI Storage Driver and EFS Creation: [click here](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)

4. Follow the steps in 0Steps.md and deploy-all.sh to provision the environment
