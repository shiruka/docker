FROM alpine/git AS REPO
RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/shiruka/shiruka.git

FROM openjdk:16
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=REPO /opt/shiruka /opt/shiruka/shiruka
WORKDIR /opt/shiruka/shiruka
RUN chmod +x gradlew
RUN ./gradlew clean build
RUN mkdir -p /opt/shiruka/server
COPY /opt/shiruka/build/libs/Shiruka.jar /opt/shiruka/server
COPY entrypoint.sh /opt/shiruka/server
WORKDIR /opt/shiruka/server
EXPOSE 19132
ENTRYPOINT ["/bin/sh", "/opt/shiruka/server/entrypoint.sh"]
CMD [""]
