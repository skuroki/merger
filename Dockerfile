FROM debian:10

RUN apt update -y && apt install -y ruby && apt install -y git
COPY webserver.rb webserver.rb
COPY main.sh main.sh
CMD ["ruby", "./webserver.rb"]
