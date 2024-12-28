
#!/bin/bash

while true; do
    echo "\nDocker Management Script"
    echo "--------------------------------"
    echo "1. List Docker Images"
    echo "2. Install an OS Image"
    echo "3. Pull Ubuntu 14.04"
    echo "4. List Running Containers"
    echo "5. Start a Container"
    echo "6. Stop a Container"
    echo "7. Remove a Container"
    echo "8. Remove an Image"
    echo "9. View Container Logs"
    echo "10. View Real-Time Container Stats"
    echo "11. Build Docker Image from Dockerfile"
    echo "12. Save Docker Image to Tar File"
    echo "13. Load Docker Image from Tar File"
    echo "14. Manage Docker Networks"
    echo "15. Manage Docker Volumes"
    echo "16. Pull Popular Docker Images"
    echo "17. Install Popular OS Images"
    echo "18. Deleting All Docker Images"
    echo "19. Create Database Images"
    echo "20. Build and Run backend tier 2 Image"
    echo "21. Run Docker Image by Name or ID..."
    
    echo "22. Rebuild existing Docker Image by Name or ID..."
    
    echo "23. Flask app with DB Image"
    echo "24. Force Deleting a Docker Image"
    echo "25. Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1)
            echo "Listing Docker Images..."
            docker images
            ;;
        2)
            echo -n "Enter the OS name or version to pull: "
            read os
            echo "Pulling OS Image $os..."
            docker pull "$os"
            ;;
        3)
            echo "Pulling Ubuntu 14.04..."
            docker pull ubuntu:14.04
            ;;
        4)
            echo "Listing Running Containers..."
            docker ps
            ;;
        5)
            echo -n "Enter the Container ID or Name to Start: "
            read container_id
            docker start "$container_id"
            ;;
        6)
            echo -n "Enter the Container ID or Name to Stop: "
            read container_id
            docker stop "$container_id"
            ;;
        7)
            echo -n "Enter the Container ID or Name to Remove: "
            read container_id
            docker rm "$container_id"
            ;;
        8)
            echo -n "Enter the Image ID or Name to Remove: "
            read image_id
            docker rmi "$image_id"
            ;;
        9)
            echo -n "Enter the Container ID or Name to View Logs: "
            read container_id
            docker logs "$container_id"
            ;;
        10)
            echo "Displaying Real-Time Container Stats..."
            docker stats
            ;;
        11)
            echo -n "Enter the Path to Dockerfile Directory: "
            read dockerfile_dir
            echo -n "Enter the Name for the Docker Image: "
            read image_name
            docker build -t "$image_name" "$dockerfile_dir"
            ;;
        12)
            echo -n "Enter the Image Name to Save: "
            read image_name
            echo -n "Enter the Path to Save the Tar File: "
            read tar_path
            docker save -o "$tar_path" "$image_name"
            ;;
        13)
            echo -n "Enter the Path to the Tar File: "
            read tar_path
            docker load -i "$tar_path"
            ;;
        14)
            echo "Managing Docker Networks..."
            echo "1. List Networks"
            echo "2. Create Network"
            echo "3. Remove Network"
            echo -n "Enter your choice: "
            read network_choice
            case $network_choice in
                1)
                    docker network ls
                    ;;
                2)
                    echo -n "Enter the Name for the New Network: "
                    read network_name
                    docker network create "$network_name"
                    ;;
                3)
                    echo -n "Enter the Name of the Network to Remove: "
                    read network_name
                    docker network rm "$network_name"
                    ;;
                *)
                    echo "Invalid choice for network management."
                    ;;
            esac
            ;;
        15)
            echo "Managing Docker Volumes..."
            echo "1. List Volumes"
            echo "2. Create Volume"
            echo "3. Remove Volume"
            echo -n "Enter your choice: "
            read volume_choice
            case $volume_choice in
                1)
                    docker volume ls
                    ;;
                2)
                    echo -n "Enter the Name for the New Volume: "
                    read volume_name
                    docker volume create "$volume_name"
                    ;;
                3)
                    echo -n "Enter the Name of the Volume to Remove: "
                    read volume_name
                    docker volume rm "$volume_name"
                    ;;
                *)
                    echo "Invalid choice for volume management."
                    ;;
            esac
            ;;
	16)
            echo "Pulling Popular Docker Images..."
            echo "1. nginx"
            echo "2. redis"
            echo "3. postgres"
            echo "4. node"
            echo "5. Other"
            echo -n "Select an image to pull: "
            read image_choice
            case $image_choice in
                1)
                    docker pull nginx
                    ;;
                2)
                    docker pull redis
                    ;;
                3)
                    docker pull postgres
                    ;;
                4)
                    docker pull node
                    ;;
                5)
                    echo -n "Enter the name of the image to pull: "
                    read custom_image
                    docker pull "$custom_image"
                    ;;
                *)
                    echo "Invalid choice for pulling images."
                    ;;
            esac
            ;;
        17)
            echo "Installing Popular OS Images..."
            echo "1. Ubuntu"
            echo "2. Alpine"
            echo "3. Debian"
            echo "4. CentOS"
            echo -n "Select an OS to install: "
            read os_choice
            case $os_choice in
                1)
                    docker pull ubuntu
                    ;;
                2)
                    docker pull alpine
                    ;;
                3)
                    docker pull debian
                    ;;
                4)
                    docker pull centos
                    ;;
                *)
                    echo "Invalid choice for OS installation."
                    ;;
            esac
            ;;
        
        18)
            echo "Deleting All Docker Images..."
            echo -n "Are you sure you want to delete all Docker images? This action cannot be undone. (yes/no): "
            read confirmation
            if [ "$confirmation" = "yes" ]; then
                docker rmi -f $(docker images -q)
                echo "All Docker images have been deleted."
            else
                echo "Operation cancelled."
            fi
            ;;
            
        19)
            echo "Setting Up Multi-Tier Application..."
            
            # Step 1: Pull Database Image
            echo "Select a Database to Pull:"
            echo "1. MySQL"
            echo "2. PostgreSQL"
            echo "3. MongoDB"
            echo "4. Other"
            echo -n "Enter your choice: "
            read db_choice
            case $db_choice in
                1)
                    db_image="mysql"
                    ;;
                2)
                    db_image="postgres"
                    ;;
                3)
                    db_image="mongo"
                    ;;
                4)
                    echo -n "Enter the name of the database image to pull: "
                    read db_image
                    ;;
                *)
                    echo "Invalid choice. Exiting..."
                    continue
                    ;;
            esac
            echo "Pulling Database Image $db_image..."
            docker pull "$db_image"
            
            # Step 2: Configure Database
            echo -n "Enter the database container name: "
            read db_container_name
            echo -n "Enter the database name to create: "
            read db_name
            echo -n "Enter the username for the database: "
            read db_user
            echo -n "Enter the password for the database: "
            read db_password
            
            echo "Starting Database Container..."
            docker run -d --name "$db_container_name" -e MYSQL_ROOT_PASSWORD="$db_password" -e MYSQL_DATABASE="$db_name" -e MYSQL_USER="$db_user" -e MYSQL_PASSWORD="$db_password" "$db_image"
            
            # Step 3: Interact with Database
            echo "Connecting to the database container..."
            docker exec -it "$db_container_name" bash -c "
                while true; do
                    echo 'Creating table in the database...';
                    echo -n 'Enter the table name: ';
                    read table_name;
                    while true; do
                        echo 'Enter the fields for the table (e.g., id INT, name VARCHAR(100)): ';
                        read table_fields;
                        mysql -u $db_user -p$db_password $db_name -e \"CREATE TABLE \$table_name (\$table_fields);\" 2>/dev/null
                        if [ \$? -eq 0 ]; then
                            echo 'Table created successfully.';
                            break;
                        else
                            echo 'Error creating table. Please check your syntax and try again.';
                        fi
                    done;

                    echo 'Now inserting data into the table...';
                    while true; do
                        echo 'Enter data to insert (or type EXIT to stop): ';
                        read data_values;
                        [ \"\$data_values\" = \"EXIT\" ] && break;
                        mysql -u $db_user -p$db_password $db_name -e \"INSERT INTO \$table_name VALUES (\$data_values);\" 2>/dev/null
                        if [ \$? -eq 0 ]; then
                            echo 'Data inserted successfully.';
                        else
                            echo 'Error inserting data. Please check your values and try again.';
                        fi
                    done;
                    echo 'Fetching table data...';
                    mysql -u $db_user -p$db_password $db_name -e \"SELECT * FROM \$table_name;\";
                    break;
                done;
            "
            ;;
            
        20)
            echo "Setting up the backend (2nd tier)..."
            
            # Step 1: Create a folder
            echo -n "Enter a name for your backend folder: "
            read backend_folder
            mkdir -p "$backend_folder"
            cd "$backend_folder" || { echo "Error: Failed to navigate to the folder."; break; }
            echo "Backend folder '$backend_folder' created."

            # Step 2: Pull popular backend images
            echo "Pulling popular backend-related Docker images..."
            echo "1. python"
            echo "2. node"
            echo "3. ruby"
            echo "4. php"
            echo "5. Other"
            echo -n "Select an image to pull: "
            read backend_image_choice
            case $backend_image_choice in
                1)
                    docker pull python
                    ;;
                2)
                    docker pull node
                    ;;
                3)
                    docker pull ruby
                    ;;
                4)
                    docker pull php
                    ;;
                5)
                    echo -n "Enter the backend image name to pull: "
                    read custom_backend_image
                    docker pull "$custom_backend_image"
                    ;;
                *)
                    echo "Invalid choice for backend image."
                    cd ..
                    break
                    ;;
            esac

            # Step 3: Create a backend program file
            echo -n "Enter the file name with extension for your backend program (e.g., app.py): "
            read backend_file
            touch "$backend_file"
            gedit "$backend_file"
            echo "Backend file '$backend_file' created and edited."

            # Step 4: Create and edit a Dockerfile
            touch Dockerfile
            gedit Dockerfile
            echo "Dockerfile created and edited."

            # Step 5: Build and Run with Error Handling
            while true; do
                # Build the Docker image
                echo -n "Enter the name for your backend Docker image: "
                read backend_image_name
                echo -n "Enter the tag for your backend Docker image (e.g., v1): "
                read backend_image_tag
                docker build -t "$backend_image_name:$backend_image_tag" .
                
                # Handle build errors
                if [ $? -ne 0 ]; then
                    echo "Error: Failed to build Docker image."
                    echo "Would you like to edit a file to fix the error? (Dockerfile or $backend_file) (y/n): "
                    read edit_choice
                    if [ "$edit_choice" == "y" ]; then
                        echo "Which file do you want to edit? (1. Dockerfile / 2. $backend_file): "
                        read file_choice
                        case $file_choice in
                            1)
                                gedit Dockerfile
                                ;;
                            2)
                                gedit "$backend_file"
                                ;;
                            *)
                                echo "Invalid choice. Skipping edit."
                                ;;
                        esac
                    else
                        echo "Build process aborted."
                        cd ..
                        break
                    fi
                    continue
                fi
                
                # Run the Docker container
                while true; do
                    echo -n "Enter a name for your backend application container: "
                    read backend_app_name
                    docker run -it --name "$backend_app_name" "$backend_image_name:$backend_image_tag"
                    
                    # Handle run errors
                    if [ $? -ne 0 ]; then
                        echo "Error: Failed to run backend application container."
                        echo "Would you like to edit a file to fix the issue? (Dockerfile or $backend_file) (y/n): "
                        read edit_choice
                        if [ "$edit_choice" == "y" ]; then
                            echo "Which file do you want to edit? (1. Dockerfile / 2. $backend_file): "
                            read file_choice
                            case $file_choice in
                                1)
                                    gedit Dockerfile
                                    ;;
                                2)
                                    gedit "$backend_file"
                                    ;;
                                *)
                                    echo "Invalid choice. Skipping edit."
                                    ;;
                            esac
                            # Rebuild after editing
                            docker build -t "$backend_image_name:$backend_image_tag" .
                            if [ $? -ne 0 ]; then
                                echo "Error: Failed to rebuild Docker image after editing."
                                continue
                            fi
                        else
                            echo "Run process aborted."
                            cd ..
                            break 2
                        fi
                    else
                        echo "Backend application container '$backend_app_name' is running successfully."
                        break 2
                    fi
                done
            done

            # Step 6: Navigate back to the original directory
            cd ..
            ;;
            
        21)
            echo "Run Docker Image by Name or ID..."
            
            # Step 1: List available Docker images
            echo "Available Docker Images:"
            docker images
            echo
            
            # Step 2: Ask the user for the image name or ID
            echo -n "Enter the Image Name or ID to run: "
            read image_name_or_id
            
            # Step 3: Ask for optional container name
            echo -n "Do you want to name the container? (y/n): "
            read name_choice
            if [ "$name_choice" == "y" ]; then
                echo -n "Enter a name for the container: "
                read container_name
                docker run -it --name "$container_name" "$image_name_or_id"
            else
                docker run -it "$image_name_or_id"
            fi
            
            # Step 4: Handle errors during the run process
            if [ $? -ne 0 ]; then
                echo "Error: Failed to run the Docker image."
                echo "Please ensure the image exists and try again."
            else
                echo "Docker image '$image_name_or_id' is running successfully."
            fi
            ;;
        
        
        22)
            echo "Rebuild Existing Docker Image..."
            
            # Step 1: List available Docker images
            echo "Available Docker Images:"
            docker images
            echo
            
            # Step 2: Ask the user for the image name or ID
            echo -n "Enter the Image Name or ID to rebuild: "
            read image_name_or_id
            
            # Step 3: Ask the user for the path to the Dockerfile
            echo -n "Enter the directory containing the Dockerfile to rebuild the image: "
            read dockerfile_dir
            
            # Step 4: Check if the directory exists
            if [ ! -d "$dockerfile_dir" ]; then
                echo "Error: Directory '$dockerfile_dir' does not exist."
                break
            fi
            
            # Step 5: Ask for the image tag (optional)
            echo -n "Enter the tag for the image (e.g., v1, latest): "
            read image_tag
            
            # Step 6: Rebuild the Docker image
            echo "Rebuilding Docker image '$image_name_or_id:$image_tag' from $dockerfile_dir..."
            docker build -t "$image_name_or_id:$image_tag" "$dockerfile_dir"
            
            # Step 7: Check if the rebuild was successful
            if [ $? -ne 0 ]; then
                echo "Error: Failed to rebuild Docker image."
            else
                echo "Docker image '$image_name_or_id:$image_tag' rebuilt successfully."
            fi
            ;;
        
        23)
            echo "Setting up a Fullstack Application with Flask and Database..."

            # Collect database details from the user
            echo -n "Enter the database image name (e.g., postgres, mysql): "
            read db_image
            echo -n "Enter the database host (default: db): "
            read db_host
            db_host=${db_host:-db}
            echo -n "Enter the database username: "
            read db_user
            echo -n "Enter the database password: "
            read -s db_password
            echo
            echo -n "Enter the database name: "
            read db_name

            # Create a new directory for the Flask app
            echo -n "Enter the directory to set up the Flask app (will be created if not exists): "
            read flask_dir
            mkdir -p "$flask_dir"

            # Generate the Flask app file
            echo "Generating Flask app boilerplate code..."
            cat > "$flask_dir/app.py" <<EOL
import os
from flask import Flask

app = Flask(__name__)

# Environment variables for the database
DB_HOST = os.getenv('DB_HOST', '$db_host')
DB_USER = os.getenv('DB_USER', '$db_user')
DB_PASSWORD = os.getenv('DB_PASSWORD', '$db_password')
DB_NAME = os.getenv('DB_NAME', '$db_name')

@app.route("/")
def home():
    return f"Connected to Database at {DB_HOST} as {DB_USER}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOL

            echo "Opening Flask app file for editing..."
            ${EDITOR:-nano} "$flask_dir/app.py"

            # Generate the Dockerfile
            echo "Generating Dockerfile..."
            cat > "$flask_dir/Dockerfile" <<EOL
FROM python:3.9-slim

WORKDIR /app
COPY . .
RUN pip install Flask
EXPOSE 5000
CMD ["python", "app.py"]
EOL

            echo "Opening Dockerfile for editing..."
            ${EDITOR:-nano} "$flask_dir/Dockerfile"

            # Build the Docker image
            echo -n "Enter a name for your Flask app image: "
            read flask_image_name
            docker build -t "$flask_image_name" "$flask_dir"

            # Run the database container
            echo "Creating and starting the database container..."
            echo -n "Enter a name for the database container: "
            read db_container_name
            docker network create fullstack-net
            docker run -d --name "$db_container_name" --network fullstack-net "$db_image"

            # Run the Flask app container
            echo "Starting the Flask app container..."
            echo -n "Enter a name for your Flask app container: "
            read flask_container_name
            docker run -d --name "$flask_container_name" --network fullstack-net -p 5000:5000 "$flask_image_name"

            echo "Your fullstack application is now running!"
            ;;


        24)
            echo "Force Deleting a Docker Image..."
            echo -n "Enter the Image ID or Name to Force Remove: "
            read image_id
            echo "Attempting to force delete the image: $image_id..."
            if docker rmi -f "$image_id"; then
                echo "Image $image_id has been forcibly removed successfully."
            else
                echo "Failed to forcibly remove the image. Please check for dependencies or errors."
            fi
            ;;


        
        
        25)
            echo "Exiting Docker Management Script. Goodbye!"
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

done
