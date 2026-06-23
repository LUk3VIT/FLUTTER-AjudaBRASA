FROM nginx:alpine

COPY ./build/web /usr/share/nginx/html

RUN flutter build web --release --verbose

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]