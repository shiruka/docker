FROM alpine/git AS REPO
RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/shiruka/shiruka.git

FROM openjdk:16 AS BUILD
RUN mkdir -p /opt
WORKDIR /opt
COPY --from=REPO /opt/shiruka ./shiruka
WORKDIR shiruka
RUN chmod +x gradlew
RUN ./gradlew clean build

FROM openjdk:16 AS APP
RUN mkdir -p /opt/shiruka
WORKDIR /opt/shiruka
COPY --from=1 /opt/shiruka/build/libs/Shiruka.jar /opt/shiruka
COPY --from=1 /entrypoint.sh /opt/shiruka
EXPOSE 19132
ENTRYPOINT ["/bin/sh", "/opt/shiruka/server/entrypoint.sh"]
CMD [""]
