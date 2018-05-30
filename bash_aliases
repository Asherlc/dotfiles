function kill-port() { lsof -ti:$1 -sTCP:LISTEN | xargs kill; }
