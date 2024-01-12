# Create the "kubernetes" folder if it doesn't exist
mkdir -p deployment

# Generate Kubernetes Deployment YAML with the retrieved tag in the "kubernetes" folder
REPO="gyanev84/github-actions"
IMAGE_NAME="my-app-container"

TAG=$(curl -s "https://registry.hub.docker.com/v2/repositories/$REPO/tags" | jq -r '.results[0].name')

echo "Latest Docker image tag: $TAG"

cat <<EOF > deployment/deployment.yaml
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

# Check if the script is running on a Linux system
if [[ "$(uname)" == "Linux" ]]; then
  sudo bash -c "cat <<EOF > deployment/deployment.yaml
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
EOF"
else
  echo "This script can only be run on a Linux system."
fi

# Check if kubectl is installed
if ! [ -x "$(command -v kubectl)" ]; then
  echo "Error: kubectl is not installed. Please install kubectl first."
  exit 1
fi

# Start Minikube (if not already started)
minikube_status=$(minikube status | grep -o "minikube: Running")
if [ "$minikube_status" != "minikube: Running" ]; then
  echo "Starting Minikube..."
  minikube start
fi

# Delete all pods in the "default" namespace
echo "Deleting all pods in the default namespace..."
kubectl delete pods --all -n default

# Apply Deployment YAML
echo "Applying Deployment YAML..."
kubectl apply -f deployment/deployment.yaml

# Wait for the Pods to be ready
echo "Waiting for Pods to be ready..."
kubectl wait --for=condition=ready pod -l app=my-app --timeout=300s

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

echo "Found a pod with label $desired_label. Pod name is $pod_name."

# Port-forward to the Pod
echo "Port-forwarding to the Pod..."
kubectl port-forward "pod/$pod_name" 8080:80 &

# Retrieve the latest Docker image tag dynamically
REPO="gyanev84/github-actions"
IMAGE_NAME="my-app-container"
TAG=$(curl -s "https://registry.hub.docker.com/v2/repositories/$REPO/tags" | jq -r '.results[0].name')
echo "Latest Docker image tag: $TAG"

# Perform other Kubernetes-related tasks as needed

# Cleanup (stop Minikube)
# Uncomment the following line if you want to stop Minikube when you're done
# minikube stop

echo "Script execution completed."
exit 1
