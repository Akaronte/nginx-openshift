Enter inside container
docker exec -ti nginx bash


certbot certonly --manual --preferred-challenges=dns --email akaronte@hotmail.com --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.apps.kube1.okd.piensoluegoinstalo.com

Add tst record in dns zona and check value:

dig _acme-challenge.apps.kube1.okd.piensoluegoinstalo.com TXT +noall +answer

secret default for all routes in openshift cluster router-certs-default -n openshift-ingress