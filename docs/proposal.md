# Project Proposal

## Overview
The webscraping cluster scrapes from Datanyze.  Data is accessible in API.

## Code
The `scrape-api` scrapes data from Website and returns either 404 or 200.

`scrape-api` endpoints:
- `/` and `all/`       - GET returns all endpoitns
- `/ci`                - GET returns [Top 10 CI Tools](https://www.datanyze.com/market-share/ci--319)
- `/config-management` - GET returns [Top 10 Configuration Management Tools](https://www.datanyze.com/market-share/configuration-management--313)
- `/containers`        - GET returns [Top 10 Containerization](https://www.datanyze.com/market-share/containerization--321)
- `/health`            - GET returns OK

```json
/* "/", and "all/" endpoints */
{
    "ci" : {
        "name" : "ci",                                             // Name of endpoint
        "url"  : "https://www.datanyze.com/market-share/ci--319",  // URL
        "date" : "2022:05:17__22:31:16",                           // UTC Date: date -u +"%Y:%m:%d__%H:%M:%S"
        "data" : {                                                 // Category data
            "1": {
                "Name"            : "Jenkins",
                "Companies Using" : 14919,
                "Market Share"    : 63.55
            },
            "2": {
                "Name"            : "JetBrains Team City",
                "Companies Using" : 1983,
                "Market Share"    : 8.45
            },
            ....
        }
    },
    "config-management" : {
        ...
    }
}

/* "ci/" endpoint */
{
    "name" : "ci",                                             // Name of endpoint
    "url"  : "https://www.datanyze.com/market-share/ci--319",  // URL
    "date" : "2022:05:17__22:31:16",                           // UTC Date: date -u +"%Y:%m:%d__%H:%M:%S"
    "data" : {                                                 // Category data
        "1": {
            "Name"            : "Jenkins",
            "Companies Using" : 14919,
            "Market Share"    : 63.55
        },
        "2": {
            "Name"            : "JetBrains Team City",
            "Companies Using" : 1983,
            "Market Share"    : 8.45
        },
        ....
    }
}

/* health/ endpoint */
OK  // Status code 200
```

## Pipeline
![Blue/Green Deployment](pipeline.png)
