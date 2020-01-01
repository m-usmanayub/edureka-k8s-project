PASS=edureka
kubectl exec -it db-pod-0 -- mysql -uroot -p${PASS} <<MYSQL_SCRIPT
CREATE DATABASE test2;
USE test2;
create table test2(name varchar(20), email varchar(20));
MYSQL_SCRIPT