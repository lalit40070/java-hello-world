FROM java:8
COPY ./my-app/target/*.jar /
ADD ./my-app/target/*.jar /usr/local/bin/
CMD java -jar my-app-1.0-SNAPSHOT.jar
