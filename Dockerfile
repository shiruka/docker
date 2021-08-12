FROM alpine/git
RUN mkdir -p /opt
WORKDIR /opt
RUN git clone https://github.com/shiruka/shiruka.git
WORKDIR /opt/shiruka
RUN chmod +x ./gradlew
RUN ./gradlew shadowJar

FROM openjdk:16
RUN mkdir -p /opt/shiruka
WORKDIR /opt/shiruka
COPY --from=0 /opt/shiruka/target/Shiruka.jar /opt/shiruka
COPY --from=0 /opt/shiruka/entrypoint.sh /opt/shiruka
EXPOSE 19132
ENTRYPOINT ["/bin/sh", "/opt/shiruka/entrypoint.sh"]
CMD [""]
