FROM madebytimo/java-nodejs-python

RUN install-autonomous.sh install Ansible Basics Docker FFmpeg Fileorganizer Htop MetadataEditors \
    OCRTools Screen Scripts ScriptsAdvanced ScriptsDesktop ScriptsDevelopment Subversion && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p --mode 0755 /var/run/sshd
COPY sshd_config /etc/ssh/

RUN mkdir --parents /media/user
RUN adduser user --disabled-password --gecos "" --home /media/user && \
    usermod --password '*' user && \
    usermod --append --groups docker user

ENV NESTED_DOCKER=""
ENV PUBLIC_KEYS=""

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sshd", "-D", "-e" ]
