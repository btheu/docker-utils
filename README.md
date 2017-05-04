# docker-utils


Installation
-----------

```
cd ~
git clone https://github.com/btheu/docker-utils
echo 'export PATH=$PATH:~/docker-utils' >> ~/.bash_profile
source ~/.bash_profile
```

Update
-----------

```
dkupgrade
```

Examples
-----------

```
dkpgsql_sql <CONTAINER> "<sql query>"  " -U user -d <database> "
```

```
dkpgsql_sql_file <CONTAINER> <sqlfile.sql>  " -U user -d <database> "
```

```
dkpgsql_restore <CONTAINER> <dumpfile.backup>  " -U user -d <database> "
```

```
dkpgsql_dump <IMAGE> <dumpfile.backup>  " -U user -d <database> -n <schema> -h <host> -p <port> --format=tar "
```

