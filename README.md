## Deployment

### Method 1: Using Docker
1. Navigate to the project folder:
    ```sh
    cd path/to/your/project
    ```
2. Build the Docker image:
    ```sh
    docker build -t exertime-image:latest .
    ```
3. Run the Docker container:
    ```sh
    docker compose up -d
    ```
4. Access the application at:
    ```
    http://localhost:5000/admin/login
    ```

### Method 2: Using local environment
1. Navigate to the project folder:
    ```sh
    cd path/to/your/project
    ```
2. Install dependencies:
    ```sh
    npm install
    ```
3. Build the project:
    ```sh
    npm run build
    ```
4. Start the application:
    ```sh
    npm run start
    ```
5. Ensure MySQL is running and properly configured.

## Additional Notes
You may use Docker to set up MySQL and use your local machine or WSL to run the application.