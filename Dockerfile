FROM debian:buster-slim

RUN apt-get update -y
RUN apt-get install -y wget
RUN apt-get install -y libncurses-dev libusb-1.0-0-dev libftdi1 libftdi1-dev libudev-dev

RUN mkdir -p /opt/lixee-dk6programmer
WORKDIR /opt/lixee-dk6programmer
RUN wget --no-verbose https://zigate.fr/wp-content/uploads/2021/05/AArch64_Buster-1.tar
RUN tar -xvf AArch64_Buster-1.tar
RUN rm --force AArch64_Buster-1.tar
RUN chmod +x DK6Programmer

ENTRYPOINT /bin/bash -i /opt/lixee-dk6programmer/DK6Programmer
CMD ["--list"]
