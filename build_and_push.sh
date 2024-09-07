docker build -f $(pwd)/Dockerfile -t kalilinux:latest .
docker tag kalilinux:latest lucasmullers/kalilinux:latest
docker push lucasmullers/kalilinux:latest