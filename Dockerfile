FROM openjdk:16

FROM alpine/git
RUN mkdir -p /opt
RUN mkdir -p /opt/shiruka
RUN mkdir -p /opt/shiruka/server

WORKDIR /opt
RUN git clone https://github.com/shiruka/shiruka.git

WORKDIR /opt/shiruka
RUN chmod +x gradlew
RUN ./gradlew build

WORKDIR /opt/shiruka/server
COPY /opt/shiruka/target/Shiruka.jar /opt/shiruka/server
COPY /opt/shiruka/entrypoint.sh /opt/shiruka/server
EXPOSE 19132
ENTRYPOINT ["/bin/sh", "/opt/shiruka/entrypoint.sh"]
CMD [""]
