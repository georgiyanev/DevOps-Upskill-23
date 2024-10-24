# Docker Container Build and Push Playbook

This Ansible playbook is designed to build a Docker container image, start a container based on that image, and then push the compiled Docker image to a DockerHub public repository. It automates the process of containerizing an application and making it available on DockerHub.

## Usage

Before running this playbook, make sure you have Ansible and Docker installed on your local machine.

1. Clone the repository containing the application source code and this playbook.

2. Update the variables in the playbook as needed:
   - `image_name`: The name of the Docker image to be created.
   - `image_tag`: The tag for the Docker image.
   - `ports_map`: The mapping of ports for the container.
   - `build_dir`: The directory where the Docker image will be built.
   - `cnt_name`: The name of the Docker container.
   - `docker_repo`: The DockerHub repository where the image will be pushed.
   - `file_owner`, `file_group`, `file_mode`: File ownership and permissions for copied files.

3. Run the playbook using the following command:

   ```bash
   ansible-playbook your_playbook.yml
