FROM debian:buster

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir /etc/nginx/ssl && \
	mkdir -p /run/nginx

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN openssl req -newkey rsa:4096 -x509 -days 30 -nodes \
				-out /etc/nginx/ssl/min-cho.crt\
				-keyout /etc/nginx/ssl/min-cho.key\
				-subj "/C=KR/SR=Seoul/L=Seoul/O=42/OU=min-cho/CN=min-cho"

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]


# SSL OPTION
# req : 인증서 요청
# -newkey : 새로운 키 생성
# rsa:4096 : RSA 알고리즘을 사용하고 4096비트의 키를 생성
# -x509 : X.509 인증서 생성
# -sha256 : SHA256 해시 알고리즘 사용
# -days : 인증서 유효기간 설정
# -nodes : 비밀번호 없이 키 생성
# -out : 인증서 파일명 설정
# -keyout : 키 파일명 설정
# -subj : 인증서 내부에 들어갈 정보 설정

#로그확인법
# docker exec -it <container name> bash
# cat /var/log/nginx/access.log 엑세스로그
# cat /var/log/nginx/error.log 에러로그