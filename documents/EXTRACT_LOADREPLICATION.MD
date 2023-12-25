## Extract and Load using [experimental] MaterializedMySQL Database Engine

#### mysql.cnf MySQL server configuration

The following are mandatory MySQL server configuration which must be set.

Stop MySQL service.

~~~shell
systemctl status mysql
systemctl stop mysql.service
~~~

Update the configuration.

~~~shell
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
~~~

~~~txt
[mysqld]
server-id                     = 223344
log_bin                       = mysql-bin
expire_logs_days              = 1
binlog_format                 = row
binlog_row_image              = FULL
default_authentication_plugin = mysql_native_password
gtid_mode                     = on
enforce_gtid_consistency      = on
~~~

ClickHouse reads binlog and performs DDL and DML queries.

Start MySQL service.

~~~shell
systemctl start mysql.service
~~~

*Reference:* [https://clickhouse.com/docs/en/engines/database-engines/materialized-mysql](https://clickhouse.com/docs/en/engines/database-engines/materialized-mysql)

#### MySQL user creation for replication

~~~shell
create user clickhouse_replication@'localhost' identified with mysql_native_password by 'ChRep$316';

grant replication slave, replication client, reload, select on *.* to clickhouse_replication@'localhost';

flush privileges;
~~~

#### CLickHouse server configuration

~~~shell
sudo systemctl status clickhouse-server
sudo systemctl stop clickhouse-server
~~~

~~~shell
sudo nano /etc/clickhouse-server/users.xml
~~~

Add/Update the following value.

~~~xml
    <profiles>
        <default>                           <allow_experimental_database_materialized_mysql>1</allow_experimental_database_materialized_mysql>
        </default>
    </profiles>
~~~

~~~shell
sudo systemctl start clickhouse-server
~~~

Login to ClickHouse server using terminal or any GUI tool and verify that the changes have been saved.

~~~shell
clickhouse-client --password   
~~~

~~~sql
SELECT
    name,
    value,
    changed,
    description
FROM system.settings
WHERE name = 'allow_experimental_database_materialized_mysql'
~~~

#### Activating the replication in ClickHouse

~~~shell
CREATE DATABASE sakila
ENGINE = MaterializeMySQL('127.0.0.1', 'sakila', 'clickhouse_replication', 'ChRep$316')
SETTINGS allows_query_when_mysql_lost = 1, max_wait_time_when_mysql_unavailable = 10000,
materialized_mysql_tables_list = 'actor,actor_info,address,category,city,country,customer,customer_list,film,film_actor,film_category,film_list,film_text,inventory,language,nicer_but_slower_film_list,payment,rental,sales_by_film_category,sales_by_store,staff,staff_list,store'
~~~

~~~shell
use sakila
show tables
~~~



CREATE DATABASE sakila
ENGINE = MaterializeMySQL('127.0.0.1', 'sakila', 'clickhouse_replication', 'ChRep$316')
SETTINGS allows_query_when_mysql_lost = 1, max_wait_time_when_mysql_unavailable = 10000,
materialized_mysql_tables_list = 'film_category'








