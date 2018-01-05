# docker-utils


Install
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

PostgreSQL tools
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
dkpgsql_dump <CONTAINER> <dumpfile.backup>  " -U user -d <database> -n <schema> --format=tar "
```

```
dkpgsql_sql_image <image> "<sql query>"  " -U user -d <database> -n <schema> -h <host> -p <port> "
```

```
dkpgsql_dump_image <IMAGE> <dumpfile.backup>  " -U user -d <database> -n <schema> -h <host> -p <port> --format=tar "
```


Pipeline build
-----------

Builderfile
```
#!/bin/bash
BUILDER_GIT_URL=https://github.com/user/reponame
BUILDER_GIT_BRANCH=develop

build(){
  RUN d_git_clone

  RUN d_maven clean install -Dmaven.test.skip=true

  DOCKER_TAGS="1.0 1.1 latest"
  RUN d_docker

  RUN d_compose
}
```

Start the pipeline build
```
dkbuilder
```
