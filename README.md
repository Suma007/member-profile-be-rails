# README

This README provides instructions on setting up and running the application.

### Ruby version
ruby-3.3.1

### System Components
The system consists of three tables: 
1. `members`: contains member details
2. `friendship`: stores friend details
3. `headings`: contains heading details from the user's website

### System Dependencies
- Sidekiq is used to run the job that retrieves headings from users' websites and adds them to the `headings` table.

### Database Setup
To create the database, run:
```
rails db:create
```
To initialize the database, run:
```
rails db:migrate
```

### Running Tests
To run the test suite, execute:
```
bundle exec rspec
```

### Services
Ensure Sidekiq is running using:
```
bundle exec sidekiq
```

### Running Locally
Follow these steps to run the application locally:

## Getting Started

To get started with the project, follow these steps:

1. Clone the repository to your local machine:

   ```bash
   git clone <repository_url>
   ```

2. Navigate to the project directory:

   ```bash
   cd member-profile-be-rails
   ```

3. Install dependencies:

   ```bash
   bundle  install
   ```
4. To initialize the database, run:
    ```
    rails db:migrate
    ```
5. Start the development server:

   ```bash
   rails s
   ```

   This command will start the app in development mode and open [http://localhost:3001](http://localhost:3001) in your default browser. The page will automatically reload if you make any changes to the source code.
6. Run the Sidekiq job to retrieve data from customers' websites:
    ```
    bundle exec sidekiq
    ```
7. Execute specs with:
    ```
    bundle exec rspec
    ```
8. Check code quality with RuboCop:
    ```
    bundle exec rubocop
    ```

### Running Redis Server on Windows
If you're using a Windows machine, you can run the Redis server using WSL. Check the status with:
```
wsl sudo service redis-server status
```

Make sure to install the necessary dependencies and configure your environment properly before running the application.