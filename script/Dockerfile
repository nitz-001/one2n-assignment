FROM alpine:latest
RUN apk --no-cache add wget
COPY script.sh /script.sh
RUN chmod +x /script.sh
CMD ["/bin/sh", "./script.sh"]