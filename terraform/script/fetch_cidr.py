import requests
import json


def fetch_cidr():
    try:
        # Replace 'FDQN' with the actual FQDN of the server
        response = requests.get('https://FDQN/vend_ip', timeout=5)
        response.raise_for_status()  # Raises a HTTPError if the response is 4xx, 5xx
        data = response.json()
        return data['ip_address'], data['subnet_size']
    except requests.exceptions.HTTPError as errh:
        print("Http Error:", errh)
    except requests.exceptions.ConnectionError as errc:
        print("Error Connecting:", errc)
    except requests.exceptions.Timeout as errt:
        print("Timeout Error:", errt)
    except requests.exceptions.RequestException as err:
        print("Oops: Something Else", err)


if __name__ == '__main__':
    # Assume fetch_cidr returns ip_address : 192.168.0.0, subnet_size: 24
    # ip_address, subnet_size = fetch_cidr()
    ip_address, subnet_size = "192.168.0.0", "16"
    if ip_address and subnet_size:
        # Output the results as a JSON-encoded string
        output = json.dumps(
            {"ip_address": ip_address, "subnet_size": subnet_size})
        print(output)
    else:
        # Output an empty JSON object if there was an error fetching the CIDR
        print(json.dumps({}))