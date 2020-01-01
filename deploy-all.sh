




echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "*              Please ensure EFS has been created correctly using the below link                     *"
echo "*                                                                                                    *"
echo "*               https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html                        *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
chmod -R +x *.sh
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
echo "*              You will be abe to Initialize the Database and table of MySQL                         *"
echo "*          Login to the database using kubectl exec it db-pod -- mysql -uroot -p                     *"
echo "*                        After login run the following commnads                                      *"
echo "*                                                                                                    *"
echo "*                                                1.                                                  *"
echo "*                                      Create database edureka;                                      *"
echo "*                                                2.                                                  *"
echo "*                       Create table edureka(name varchar(20), email varchar(20));                   *"
echo "*                                                3.                                                  *"
echo "*                                               exit                                                 *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
echo
#kubectl exec -it db-pod -- mysql -uroot -p
echo "Step5: Deploying frontends "
./frontend/frontend.sh

echo "Step 6: Deploying Ingress Controller and Ingress"

./ingress/ingress.sh

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

echo "******************************************************************************************************"
echo "*                                                                                                    *"
echo "*                                       LAST REQUIREMENT                                             *"
echo "*                                                                                                    *"
echo "* The default backend page for the ingress, should be modified to have the following data: 'Custom   *"
echo "*                                             Default Backend'                                       *"
echo "*                                                                                                    *"
echo "*               For custom ingress error page follow the steps in following article                  *"
echo "* https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/customization/custom-errors  *"
echo "\n\n\n\n"

echo "*  Edit the nginx-ingress-controller Deployment and set the value of the --default-backend-service   *"
echo "*                   flag to the name of the newly created error backend service                      *" 
echo 
echo 
echo "*                              kubectl edit nginx-ingress-controller                                 *"
echo "*                             --default-backend-service nginx-custom                                 *"
echo 
echo
echo "*                        Edit the nginx-configuration ConfigMap and create                           *"
echo "*                      the key custom-http-errors with a value of 404,503.                          *"
echo "*                                                                                                    *"
echo "*                                                                                                    *"
echo "******************************************************************************************************"
