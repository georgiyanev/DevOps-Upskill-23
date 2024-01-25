# Create the "kubernetes" folder if it doesn't exist
sudo mkdir -p deployment

# Generate Kubernetes Deployment YAML with the retrieved tag in the "kubernetes" folder
REPO="gyanev84/github-actions"
IMAGE_NAME="my-app-container"
TAG=$(curl -s "https://registry.hub.docker.com/v2/repositories/$REPO/tags" | jq -r '.results[0].name')

echo "Latest Docker image tag: $TAG"

deploy_yaml_content=$(cat <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: $IMAGE_NAME
          image: $REPO:$TAG
          ports:
            - containerPort: 80
EOF
)
if [[ "$(uname)" == "Linux" ]]; then
  echo "$deploy_yaml_content" | sudo tee deployment/deployment.yaml > /dev/null
else
  echo "$deploy_yaml_content" > deployment/deployment.yaml
fi
