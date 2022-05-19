from bs4 import BeautifulSoup
from time import gmtime, strftime

import re
import requests


# Variables
HEADERS     = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko)'
                    'Chrome/101.0.4951.64 Safari/537.36'
}
URL_TIMEOUT = 5

def get_dataynze_top_tech(url, name):
    """Performs HTTP GET at Metacritic URL, parse and returns Top Games List"""
    # Variables
    tech_list = []
    response  = {}
    count     = 1

    # HTTP GET Request
    r = requests.get(url, headers=HEADERS, timeout=URL_TIMEOUT)
    if r.status_code != 200:
        print(f"Please check connection to {url}")
        soup = BeautifulSoup(r.content, 'html.parser')
        response = {
            "name"        : name,
            "message"     : soup.text.split(),
            "status code" : r.status_code
        }
        return response

    # HTML Parser
    soup = BeautifulSoup(r.content, 'html.parser')
    data = soup.find('table', {
        'class': 'table-public'
    })

    # Set Up Response
    response["name"] = name
    response["url"]  = url
    response["date"] = strftime("%Y:%m:%d__%H:%M:%S", gmtime())
    response["data"] = {}

    # Find all Tech
    tech_list = data.findAll('tr', {
        '_ngcontent-category-page-c22' : '',
        'class'                        : 'dn-table-row'
    })

    # Find all Elements in Tech List
    for tech in tech_list:
        tech_name     = ""
        company       = ""
        description   = ""
        num_companies = 0
        market_share  = 0.0
        
        # Parse through HTML
        data = tech.findAll('a', {
            '_ngcontent-sc32' : '',
            'class'           : 'button-text-link'
        })
        tech_name = data[0].text.strip()
        company   = data[1].text.strip()

        description = tech.find('p', {
            '_ngcontent-sc31' : '',
            'class'           : 'tech-description'
        }).text.strip()

        data = tech.findAll('td', {
            '_ngcontent-sc32' : '',
            'class'           : 'text-left'
        })        

        num_companies = data[2].text.strip()
        num_companies = re.sub('[^0-9]','', num_companies)
        num_companies = int(num_companies)

        market_share = data[3].text.strip()
        market_share = re.sub('[^0-9|.]','', market_share)
        market_share = float(market_share)

        # Insert Response Data Entry
        response["data"][count] = {
            "Name"                      : tech_name,
            "Company"                   : company,
            "Description"               : description,
            "Number of Companies Using" : num_companies,
            "% Market Share"            : market_share
        }
        count += 1
    
    return response
