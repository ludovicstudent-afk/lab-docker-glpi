# lab-docker-glpi

Déploiement de GLPI 10.0.16 avec Docker Compose (GLPI + MySQL + Redis).

## Stack

- **GLPI 10.0.16** — application de gestion de parc informatique
- **MySQL 8.0** — base de données
- **Redis 7** — cache des sessions

## Prérequis

- Docker
- Docker Compose

## Installation

```bash
git clone https://github.com/ludovicstudent-afk/lab-docker-glpi.git
cd lab-docker-glpi
cp .env.example .env
nano .env
docker compose up -d
```

## Configuration du .env

| Variable | Description |
|---|---|
| MYSQL_ROOT_PASSWORD | Mot de passe root MySQL |
| MYSQL_DATABASE | Nom de la base de données |
| MYSQL_USER | Utilisateur MySQL |
| MYSQL_PASSWORD | Mot de passe MySQL |
| MYSQL_DEFAULT_AUTHENTICATION_PLUGIN | Plugin d'auth MySQL |
| GLPI_DB_HOST | Hôte de la base (laisser `db`) |
| GLPI_DB_NAME | Même valeur que MYSQL_DATABASE |
| GLPI_PORT | Port exposé (défaut : 8080) |

## Accès

Une fois la stack démarrée, accéder à GLPI via :

```
http://IP_SERVEUR:8080
```

Configuration au premier lancement :
- Serveur SQL : `db`
- Utilisateur : valeur de `MYSQL_USER`
- Mot de passe : valeur de `MYSQL_PASSWORD`
- Base de données : valeur de `MYSQL_DATABASE`

## Structure du projet

```
lab-docker-glpi/
├── docker-compose.yml
├── .env                  # non versionné
├── .env.example          # template
├── .gitignore
└── docker/glpi/
    ├── Dockerfile
    ├── entrypoint.sh
    └── glpi-apache.conf
```

## Image Docker

L'image GLPI est disponible sur Docker Hub :

```
ludowa/glpi-app:latest
```
