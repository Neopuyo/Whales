#!/bin/bash

# Le script effectue les étapes suivantes :
 # - [1] Génère une clé privée RSA.
 # - [2] Génère une demande de signature de certificat (CSR) 
 #       à partir de la clé privée.
 # - [3] Signe la CSR pour générer un certificat auto-signé valide.
 # - [4] Exécute les commandes spécifiées lors du lancement du conteneur.

#[1]
# commande openssl genrsa
# generation d'une cle privee RSA 2048 bits
# -out chemin/ou/sera/l'objet/genere
openssl genrsa -out /etc/nginx/ssl/private.key 2048

#[2]
# commande openssl req
# génère une demande de signature de certificat (CSR)
# -key -> utilise la clee ci dessus
# -subj -> les infos a donner necessaires
openssl req -new -key /etc/nginx/ssl/private.key \
        -out /etc/nginx/ssl/csr.pem \
        -subj "/C=FR/ST=Paris/L=Paris/O=MonEntreprise/CN=example.com"

#[3]
# commande openssl x509
# signer le certificat CSR (Certificate Signing Request)
# avec la cle et générer
# un certificat auto-signé valide pendant 365 jours
openssl x509 -req -days 365 -in /etc/nginx/ssl/csr.pem \
        -signkey /etc/nginx/ssl/private.key \
        -out /etc/nginx/ssl/certificate.crt

#[4]
# permet de lancer le service Nginx à partir de 
# la commande spécifiée dans le CMD du Dockerfile
exec "$@"



# Procédure (hors autosignature pour dev. en local)
# https://fr.wikipedia.org/wiki/Demande_de_signature_de_certificat
# Avant de créer un CSR, le requérant crée une paire de clés 
# (une publique et une privée) en gardant la clé privée secrète. 
# Le CSR contient des informations d'identification du demandeur
# (examiné comme un nom unique dans le cas d'un certificat X.509), 
# et la clé publique choisie par le demandeur.
# La clé privée correspondante n'est pas incluse dans le CSR,
# mais est utilisée pour signer numériquement la demande.

# Si la demande est acceptée, l'autorité de certification retourne un
# certificat d'identité signé numériquement avec la clé privée 
# de l'autorité de certification. 