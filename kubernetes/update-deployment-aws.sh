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

# Get the Pod name dynamically
desired_label="app=my-app"
pod_name=""
timeout_seconds=300
start_time=$(date +%s)

while [ -z "$pod_name" ]; do
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))

  if [ "$elapsed_time" -ge "$timeout_seconds" ]; then
      echo "Timeout: Pod with label $desired_label did not become available within $timeout_seconds seconds."
      exit 1
  fi

  pod_name=$(kubectl get pods -l "$desired_label" -o jsonpath='{.items[0].metadata.name}')

  if [ -z "$pod_name" ]; then
      echo "Waiting for a pod with label $desired_label to become available..."
      sleep 5
  fi
done

kubectl apply -f deployment/deployment.yaml
kubectl port-forward "pod/$pod_name" 8080:80 &

exit 0
