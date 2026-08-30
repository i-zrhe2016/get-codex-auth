ARG KASM_IMAGE=kasmweb/chromium
ARG KASM_TAG=1.19.0
FROM ${KASM_IMAGE}:${KASM_TAG}

USER root

ENV DEBIAN_FRONTEND=noninteractive \
    HOME=/home/kasm-default-profile \
    NODE_MAJOR=22 \
    STARTUPDIR=/dockerstartup

WORKDIR /tmp

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git gnupg \
    && mkdir -p /usr/share/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /usr/share/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
        > /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g @openai/codex \
    && apt-get purge -y --auto-remove curl gnupg \
    && rm -rf /var/lib/apt/lists/*

COPY src/common/scripts/kasm_hook_scripts/ ${STARTUPDIR}/
RUN chmod 755 ${STARTUPDIR}/kasm_post_run_root.sh \
    && mkdir -p /home/kasm-user/.codex \
    && chown -R 1000:0 /home/kasm-user/.codex \
    && chown 1000:0 /home/kasm-user \
    && ${STARTUPDIR}/set_user_permission.sh /home/kasm-user

ENV HOME=/home/kasm-user

WORKDIR /home/kasm-user

USER 1000

CMD ["--tail-log"]
