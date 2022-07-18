# Project Overview
The webscraping cluster scrapes user defined websites and saves them off to a Data Storage.  Data is then accessible in an API.

## Scrape API

The `scrape-api` runs on port 5001 and scrapes data from Website and returns either 404 or 200.  It can also be used read persistent data from data storage (ie. RDS).

`scrape-api` endpoints:
- `/` and `/all` - GET returns all $category endpoints
- `/$CATEGORY`   - GET returns all data from category from live websites
    - `/config-management` - GET returns [Top 10 Configuration Management Tools](https://www.datanyze.com/market-share/configuration-management--313)
    - `/containers`       - GET returns [Top 10 Containerization](https://www.datanyze.com/market-share/containerization--321)
- `$CATEGORY/archive`   - GET returns all data from a category from all time stamps saved in data storage
    - `$CATEGORY/archive?start=[$START_DATE]&end=[$END_DATE]` - GET returns query from start and end range in MM-DD-YYYY format
- `/cfg`         - GET returns Config Settings
- `/health`      - GET returns OK
- `/status`      - GET returns list of services and status ie. `scrape-bot` and `rds`
- `/version`     - GET returns versions for service


```json
/* "/", and "/all" endpoints */
{
    "config-management" : {
        "name": "config-management",
        "url": "https://...",
        "date": "2022:05:18__18:47:50",
        "data": {
            "1": {
                "Name": "Ansible",
                "Company": "Red Hat",
                "Description": "...",
                "Number of Companies Using": 9542,
                "% Market Share": 25.35
            },
            "2": {
                ...
            },
            ...
        }
    },
    "containers" : {
        ...
    }
}

/* "/config-management" endpoint */
{
    "name": "config-management",
    "url": "https://...",
    "date": "2022:05:18__18:47:50",
    "data": {
        "1": {
            "Name": "Ansible",
            "Company": "Red Hat",
            "Description": "...",
            "Number of Companies Using": 9542,
            "% Market Share": 25.35
        },
        "2": {
            ...
        },
        ...
    }
}

/* /cfg endpoint */
{
    "version": "0.0.1",
    "urls": {
        "config-management": "https://...",
        "costco-meats": "https://...",
        ...
    },
    "ports": {
        "scrape-api": 5001,
        "scrape-bot": 5002,
        "scrape-rds": 3006,
    },
    "urls": {
        "scrape-api": "http://127.0.0.1",
        "scrape-bot": "http://127.0.0.1",
        "scrape-rds": "http://$AWS_DNS_NAME",
    },
    ...
}  // Status code 200

/* /health endpoint */
OK  // Status code 200

/* /status endpoint */
{
    "scrape-api": {
        "port": 5001,
        "status": "OK"
    },
    "scrape-bot": {
        "port": 5002,
        "status": "OK"
    },
    "scrape-rds": {
        "port": 3306,
        "status": "DOWN"
    }
}   // Status code 200

/* /version endpoint */
"0.0.1" // Status code 200
```

## Scrape Bot

The `scrape-bot` is a process that resides on port `5002` and performs the following functions:
- scrapes all the endpoints at predefinied intervals
- performs CRUD operations with all that data to the RDS

The following endpoints exists

- `/cfg`         - GET returns Config Settings
- `/health`      - GET returns OK
- `/version`     - GET returns versions for service