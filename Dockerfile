FROM ubuntu 
COPY ["./*", "/root/"]
RUN sh /root/setup.sh
WORKDIR /root
EXPOSE 22 80
CMD ["/bin/sh", "/root/start.sh"]
