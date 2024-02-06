FROM ubuntu:20.04
RUN apt update && apt install -y python3
WORKDIR /var/www/html
# RUN echo "Hello, <strong>Docker</strong>" > index.html
# 위를 COPY를 통해 해결  
# COPY ["index.html", "."]
# -u 옵션을 써야 현재 상태, 로그가 화면에 출력
# run은 빌드가 되는 시점에 -> img, cmd는 컨테이너에 시행되는 결과 -> cmd
CMD ["python3", "-u", "-m", "http.server"]