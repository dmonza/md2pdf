# md2pdf en contenedor — el usuario solo necesita Docker.
# Base oficial de pandoc (multi-arch, pandoc 3.x). Le sumamos Typst y fuentes.
FROM pandoc/core:latest

ARG TYPST_VERSION=0.15.0

USER root

# bash (el script lo necesita), fuentes de lectura/mono y utilidades para bajar Typst
RUN apk add --no-cache \
      bash \
      ttf-dejavu ttf-liberation font-noto \
      curl tar xz \
 && arch="$(uname -m)" \
 && case "$arch" in \
      x86_64)  T="x86_64-unknown-linux-musl";; \
      aarch64) T="aarch64-unknown-linux-musl";; \
      *) echo "Arquitectura no soportada: $arch" >&2; exit 1;; \
    esac \
 && curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-${T}.tar.xz" -o /tmp/typst.tar.xz \
 && tar -xJf /tmp/typst.tar.xz -C /tmp \
 && mv "/tmp/typst-${T}/typst" /usr/local/bin/typst \
 && rm -rf /tmp/typst* \
 && typst --version

# Se inyecta el código fuente de la herramienta en la imagen
COPY md2pdf /usr/local/bin/md2pdf
RUN chmod +x /usr/local/bin/md2pdf

# pandoc/core trae ENTRYPOINT=pandoc; lo reemplazamos por nuestra CLI
ENTRYPOINT ["md2pdf"]
WORKDIR /work
