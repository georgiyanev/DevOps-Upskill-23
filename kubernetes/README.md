# Dynamic Docker Image Tag Update for Kubernetes Deployment

This README provides instructions on how to use a Bash script to dynamically update a Kubernetes Deployment YAML file with the latest Docker image tag from a Docker repository. This can be useful for automating the deployment process while ensuring that the latest version of the container image is used.

## Prerequisites

Before you begin, ensure that you have the following prerequisites installed on your local machine:

- [Docker](https://docs.docker.com/get-docker/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [jq](https://stedolan.github.io/jq/download/) (a command-line JSON processor)

## Usage

Follow these steps to execute the Bash script and update your Kubernetes Deployment:

1. **Clone or Download this Repository**:

   Clone this repository or download the script and README file to your local machine.

2. **Open a Terminal**:

   Open a terminal or command prompt on your local machine.

3. **Navigate to the Repository Directory**:

   Use the `cd` command to navigate to the directory where you downloaded or cloned the repository.

4. **Make the Script Executable**:

   Run the following command to make the Bash script executable:

   ```bash
   chmod +x update-deployment.sh
