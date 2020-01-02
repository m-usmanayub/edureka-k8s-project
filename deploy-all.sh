
echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*              Please ensure EFS has been created correctly using the below link                     *"
echo "*                                                                                                    *"
echo "*               https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html                        *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
echo " MAKE SURE YOU RUN THIS SCRIPT IN THE MAIN DIRECTORY OF PROJECT FILES"

find . -name "*.sh" -type f | xargs chmod +x
echo "Step 1: Deploying the AWS EFS CSI Storage Driver. Make sure you have whitelisted the EKS Cluster VPC "
./efs-csi.sh
echo
echo 
echo "EFS CSI Driver Deployed"
#read -p "Please enter AWS EFS File system ID (example: fs-47a2c22e)" fs_id
echo
#read -p "Please enter AWS Region (example: us-west-2)" aws_region
echo
#read -p "Please enter Domain name for ingress routing (example: your-domain.com)" your_domain
echo
echo "Step 2: Deploying Storage Class, Persistent Volume Claim and Persistent Volume for DB"
./pv/pv.sh

echo "Step 3: 3Deploying the Database Secret to be injected to Frontends"
./secret/secret.sh

echo "Secret has been created"

echo "Step 4: Deploying Database and its Service"
./database/db.sh
echo
echo
echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*                     You must Initialize the Database and table of MySQL                            *"
echo "*          Login to the database using kubectl exec it db-pod-0 -- mysql -uroot -p                   *"
echo "*                        After login run the following commnads                                      *"
echo "*                                                                                                    *"
echo "*                                                1.                                                  *"
echo "*                                      create database edureka;                                      *"
echo "*                                             use edureka;                                           *"
echo "*                                                2.                                                  *"
echo "*                       create table edureka(name varchar(20), email varchar(20));                   *"
echo "*                                                3.                                                  *"
echo "*                                               exit                                                 *"
echo "*                       OR run the script dbinit.sh once the خod is up and running                   *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
echo

# PASS=edureka
# kubectl exec -it db-pod-0 -- mysql -uroot -p${PASS} <<MYSQL_SCRIPT
# CREATE DATABASE test2;
# USE test2;
# create table test2(name varchar(20), email varchar(20));
# MYSQL_SCRIPT


echo "Step5: Deploying frontends "
./frontend/frontend.sh

echo "Step 6: Deploying Ingress Controller and Ingress"

./ingress/ingress.sh

echo "Wait and check if all the pods are up and running >> kubectl get pods --all-namespaces"


echo "Check the AWS Load Balancer URL and try to Browse!!!"
# echo "******************************************************************************************************"
# echo "*                                                                                                    *"
# echo "*                                                                                                    *"
# echo "*                          You can now access your website at:                                       *"
# echo "*                                                                                                    *"
# echo "*                                    $HOST_NAME/users                                                *"
# echo "*                                                                                                    *"
# echo "*                                    $HOST_NAME/admin                                                *"
# echo "*                                                                                                    *"
# echo "*                                                                                                    *"
# echo "******************************************************************************************************"
# read -p "Press any key to continue"