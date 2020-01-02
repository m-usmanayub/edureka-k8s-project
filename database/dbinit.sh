PASS=edureka
kubectl exec -it db-pod-0 -- mysql -uroot -p${PASS} <<MYSQL_SCRIPT
CREATE DATABASE edureka;
USE test2;
create table edureka(name varchar(20), email varchar(20));
MYSQL_SCRIPT