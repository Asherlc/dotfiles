function kill-port() { lsof -ti:$1 -sTCP:LISTEN | xargs kill; }
function nuke-docker() {
  docker stop $(docker ps -a -q) || true;
  docker rm $(docker ps -a -q) -v | true;
  docker rmi $(docker images -q) -f || true;
  docker system prune -f || true;
  docker volume prune -f; }
function dotenv() { export $(cat .env | xargs); }
