# Use a specific version of OpenJDK
FROM openjdk:11

# Set the working directory
WORKDIR /javaapp

# Copy only the necessary source files
COPY HelloWorld.java .

# Compile the Java program
RUN javac HelloWorld.java

# Set the default command to run the Java program
CMD ["java", "HelloWorld"]
