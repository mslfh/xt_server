## Deployment
### Using local environment
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
5. Ensure MySQL is running and properly configured. The sql file is in ./src/db.

## API Development

https://docs.adminjs.co/installation/adapters

We use Sequelize to build adapters.

### Simple Demo
1. Build /models/organisation.ts instance based on tables in Mysql

2. Add organisation model into the resources in ./admin/option.ts file.

3. Rebuild project.
  Test in http://localhost:5000/admin/api/resources/organisation/actions/list

4. This demo achieved basic CRUD actions by adminJs automatically. Please DO NOT edit the file that has been configured!!!

5. You may need to build more complex action or model by yourself. (https://docs.adminjs.co/basics)

## Additional Notes
You may set up MySQL on your local machine to run the application.
