FROM alpine/git AS REPO
RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/shiruka/shiruka.git

FROM openjdk:16
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=REPO /opt/shiruka ./shiruka
WORKDIR ./shiruka
RUN chmod +x gradlew
RUN ./gradlew clean build
RUN mkdir -p ./server
COPY ./build/libs/Shiruka.jar ./server
COPY entrypoint.sh ./server
WORKDIR ./server
EXPOSE 19132
ENTRYPOINT ["/bin/sh", "/opt/shiruka/server/entrypoint.sh"]
CMD [""]
