# Search all IPs in a list of subnets for SSL certificates that will expire
# in the near future. 

import socket, ssl, pprint
from netaddr import *
import time
from datetime import datetime
from datetime import timedelta

threshold = 90 #days until cert expiration
subnets = ['10.10.10.1/24','10.10.11.1/24'] #subnets to scan

def printCertInfo(IPaddress):
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  s.settimeout(3)
  # require a certificate from the server
  ssl_sock = ssl.wrap_socket(s,
                             ca_certs="/etc/ssl/certs/ca-certificates.crt",
                             cert_reqs=ssl.CERT_REQUIRED)
  try:
    ssl_sock.connect((IPaddress, 443))
  except:
    return
  expirationString = str(ssl_sock.getpeercert()['notAfter'])
  expirationDate = time.strptime(expirationString,"%b %d %H:%M:%S %Y %Z")
  expirationDatetime = datetime.fromtimestamp(time.mktime(expirationDate))
  if expirationDatetime < datetime.now()+timedelta(days=threshold):
    print("!!"),
  print(expirationString+','),
  print(IPaddress+','),
  for tuple in ssl_sock.getpeercert()['subject']:
    if tuple[0][0] == 'commonName':
      print(tuple[0][1]+',')
  ssl_sock.close()

for subnet in subnets:
  network = IPNetwork(subnet)
  for ip in network:
    printCertInfo(str(ip))
