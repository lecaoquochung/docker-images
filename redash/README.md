# docker-redash

## how to run
- init .env
```code
cp env .env
```

- init database
```code
docker-compose run --rm redash-server create_db
```

- start servers
```code
docker-compose up -d
```

- config server
```code
http://localhost:55000
```