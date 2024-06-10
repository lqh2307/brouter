FROM gradle:jdk17-jammy as build

WORKDIR /tmp/brouter

ADD . .

RUN ./gradlew clean build

FROM openjdk:17.0.1-jdk-slim

COPY --from=build /tmp/brouter/brouter-server/build/libs/brouter-*-all.jar /brouter.jar
COPY --from=build /tmp/brouter/misc/scripts/standalone/* /bin
COPY --from=build /tmp/brouter/misc/profiles2 /profiles2

RUN chmod -R +x /bin
RUN mkdir /customprofiles /segments4

VOLUME /data

EXPOSE 17777

CMD /bin/server.sh
