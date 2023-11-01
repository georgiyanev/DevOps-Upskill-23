# M1-3-1 Configuration Management

## Ansible Task

Create an Ansible playbook that build, push and then run the Docker image for the Python application. Let your playbook has the following variables:

- `image_name` - contains the name of your image without the tag, i.e. `gyanev84/python-app`
- `image_tag` - contains the tag you tagged your image with, i.e. `v0.2`
- `listen_port` - contains the listening port you're binding your app to.

Make sure that you set environment variable `PORT` when you define your container in the Ansible playbook that takes its value from `listen_port` variable.

Use Ansible modules. Do not shell out.

### Requirements

- Make sure you have Python installed. Any version above 3.8 would suffice.
- The `requirements.txt` file in this directory contains the required Ansible version. Run

```sh
pip install -r requirements.txt
```

- Make sure that Docker is running on your local machine.

### Mind the following

- If you're running Docker Desktop or Rancher Desktop, mind the location of the `docker.sock` file. The location of the socket file is

  - Docker Desktop - `${HOME}/.docker/run/docker.sock`
  - Rancher DEsktop - ${HOME}/.rd/run/docker.sock

- If you're using one of the above, when you write your Ansible playbook you must specify the path to the docker socket with the parameter `docker_host`, i.e. `docker_host: "unix://{{ ansible_env.HOME }}/.rd/docker.sock"`.
