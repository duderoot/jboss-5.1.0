FROM jboss/base:latest


# User root user to install software
USER root

# Install necessary packages
RUN yum -y update
RUN yum -y install java-1.6.0-openjdk-devel && yum clean all
RUN yum -y install mysql
RUN yum -y install dejagnu dejavu-sans-mono-fonts dejavu-serif-fonts
# Switch back to jboss user
USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java
ENV JBOSS_SHA1 bee49ee4dd833e6cfa6c87628065cc38939be7783f034e300e9d94028d31c573
ENV JBOSS_VERSION 5.1.0.GA
ENV JBOSS_HOME /opt/jboss/jboss-5.1.0


RUN cd $HOME \
    && curl -O -L https://downloads.sourceforge.net/project/jboss/JBoss/JBoss-$JBOSS_VERSION/jboss-$JBOSS_VERSION-jdk6.zip \
    && sha1sum jboss-$JBOSS_VERSION-jdk6.zip | grep $JBOSS_SHA1 \
    && unzip jboss-$JBOSS_VERSION-jdk6.zip \
    && mv $HOME/jboss-$JBOSS_VERSION $JBOSS_HOME \
    && rm jboss-$JBOSS_VERSION-jdk6.zip

# Expose the ports we're interested in
EXPOSE 8080

# Set the default command to run on boot
CMD ["/opt/jboss/jboss-5.1.0/bin/run.sh", "-b", "0.0.0.0"]
