FROM debian:buster-slim

RUN apt-get update -y
RUN apt-get install -y wget
RUN apt-get install -y libncurses-dev libusb-1.0-0-dev libftdi1 libftdi1-dev libudev-dev

WORKDIR /tmp
RUN wget --no-verbose https://zigate.fr/wp-content/uploads/2021/05/x86_64.tar
RUN tar -xvf x86_64.tar
RUN mv x86_64/DK6Programmer /usr/local/bin/
RUN chmod +x /usr/local/bin/DK6Programmer
RUN rm -rf /tmp/*

ADD lixee-dk6programmer.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/lixee-dk6programmer.sh
RUN ls -lh /usr/local/bin/ | grep -i DK6Programmer

ENTRYPOINT ["lixee-dk6programmer.sh"]