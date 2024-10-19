# Docker Integration for Project

This guide will walk you through the Docker integration for both the frontend (Quasar) and backend (AdminJS) of the project. Follow these steps to get the application running inside Docker containers.

## Prerequisites

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) and ensure it is running on your system.
2. Ensure you have a stable internet connection.
3. **Start the Docker Desktop application before running the below commands.**
 
## Getting Started with Docker

1. **Create and Run Docker Containers**
   
   First, start by creating the Docker network and containers:

   ```bash
   # Create a network for the containers
   docker network create app-network

   # Build and start the containers
   docker-compose build
   docker-compose up
   ```

2. **Stop Containers**
   
   To stop the running containers:

   ```bash
   docker-compose down
   ```

3. **Reset Containers and Volumes**
   
   To stop and remove the containers, along with associated volumes (this will delete the `adminjs` database):

   ```bash
   docker-compose down -v
   ```

4. **Access Logs**

   You can check the logs of the containers with:

   ```bash
   docker logs quasar-container
   ```

## Useful Docker Commands

### General Commands

- **Inspect Network:**

  ```bash
  docker network inspect app-network
  ```

- **Check Environment Variables:**

  ```bash
  docker exec -it adminjs-container printenv
  docker exec -it mysql-container printenv
  docker exec -it quasar-container printenv
  ```

- **Make API Call from Quasar to Backend:**

  To verify if the frontend can access the backend:

  ```bash
  docker exec -it quasar-container curl http://localhost:9000/
  ```

### Database Access

You can directly access the MySQL database inside the Docker container using:

```bash
docker exec -it mysql-container mysql -u root -p
```

- The password for the root user is `root`.

## Troubleshooting

### 1. Command Not Found (`$'\r'` error)

If you encounter the following errors:

```bash
mysql-init.sh: $'\r': command not found
wait-for-mysql.sh: $'\r': command not found
```

**Solution:**

1. Open the `mysql-init.sh` file in VS Code.
2. In the bottom-right corner, change `CRLF` to `LF`.
3. Repeat the same steps for the `wait-for-mysql.sh` file.
4. Save both files and rebuild the containers.

### 2. Port 3306 Already in Use

If you encounter the following error:

```bash
Error response from daemon: Ports are not available: exposing port TCP 0.0.0.0:3306
```

**Solution:**

1. Check if port 3306 is in use:

   ```bash
   netstat -aon | findstr :3306
   ```

2. If MySQL is already running on your system and occupying port 3306, stop it:

   ```bash
   net stop mysql
   ```
   
## Conclusion

This setup will allow you to run your project inside Docker containers for both the frontend (Quasar) and backend (AdminJS). If you encounter any issues, follow the troubleshooting steps or inspect the Docker logs for further debugging.

## Notes:

- The password for MySQL is `root`, and this is initialized in the backend `docker-compose.yaml` file.
- **Important:** Be sure to use `docker-compose down -v` carefully as it will delete all Docker volumes, including your database.