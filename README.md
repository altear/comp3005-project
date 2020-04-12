# Installation

Install docker and docker-compose

# Running

```
docker-compose up -d
```

# Stopping

```
docker-compose down
```

### Useful Commands

#### Show logs

```
docker-compose logs
```

#### Show logs for service

```
docker-compose logs <service>
```

#### Update builds
```
docker-compose build --no-cache
```

#### Run command in service

```
docker-compose run <service> <command...>
```

### Restart single service

```
docker-compose restart <service>
```

#### Connect to DB Interactively

```
docker-compose run db bash
psql "dbname=docker host=db user=docker password=docker port=5432"
```

