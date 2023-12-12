REPO="gyanev84/github-actions"
IMAGE_NAME="my-app-container"

TAG=$(curl -s "https://registry.hub.docker.com/v2/repositories/$REPO/tags" | jq -r '.results[0].name')

echo "Latest Docker image tag: $TAG"

cat <<EOF > deployment.yaml
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
