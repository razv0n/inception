FROM debian:bookworm

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req  -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=MA/ST=Casablanca/L=Casablanca/O=1337/CN=mfahmi.42.fr"

COPY ./conf/nginx.conf /etc/nginx/sites-available/nginx.conf

RUN ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

ENTRYPOINT ["nginx","-g","daemon off;"]

# The biggest lesson

# A certificate has two jobs:

# Help establish an encrypted connection
# Prove the server's identity
#inside the cert Certificate
# ├── Public Key
# ├── Common Name (CN)
# ├── Organization (O)
# ├── Country (C)
# ├── Valid From
# ├── Valid Until
# ├── Issuer
# └── Digital Signature
# opens