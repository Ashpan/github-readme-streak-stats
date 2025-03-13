FROM --platform=linux/amd64 ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt update && \
    apt install -y php php-curl php-xml php-mbstring composer inkscape git && \
    apt clean
RUN git clone https://github.com/Ashpan/github-readme-streak-stats.git /github-readme-streak-stats
WORKDIR /github-readme-streak-stats

RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'echo "TOKEN=$TOKEN" > .env' >> /entrypoint.sh && \
    echo 'exec "$@"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

RUN composer install
EXPOSE 8000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php", "-S", "0.0.0.0:8000", "-t", "src"]