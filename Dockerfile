FROM alpine:3.23

RUN mkdir /prince && \
    apk add --no-cache \
        libxml2 \
        pixman \
        tiff \
        giflib \
        libpng \
        lcms2 \
        libjpeg-turbo \
        fontconfig \
        freetype \
        libgomp \
        libwebpdemux \
        libavif \
        aom-libs

WORKDIR /prince

RUN apk add --no-cache curl && \
    curl https://www.princexml.com/download/prince-16.2-alpine3.23-x86_64.tar.gz -o prince.tar.gz && \
    tar -zxvf prince.tar.gz && \
    rm prince.tar.gz

# Install fonts
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

ENTRYPOINT [ "./prince-16.2-alpine3.23-x86_64/lib/prince/bin/prince" ]
