# Alpine is strong, in this case, with only geocoder instalation that is not part of any standard precompild wheels
FROM python:3.10.8-alpine3.16 AS env-build
# Server running as non-root ~ security precaution.
# Upgrading pip and apk to install security updates. 
RUN set -eux; \
    USERNAME='rt-py-user'; \
    adduser --disabled-password -g "${USERNAME}" $USERNAME; \
    python -m pip install --upgrade pip; \
    apk -U upgrade; \
    mkdir /home/rt-py-user/rt-py-server; 

# Organizing for possible enhancements. 
WORKDIR /home/rt-py-user/rt-py-server
# Could be done via remote repository github ssh but unnessary
COPY ["main.py", "requirements.txt", "./"]
# Dockerfile Reproducibility
RUN python -m pip install -r requirements.txt 

USER rt-py-user
EXPOSE 80/tcp

ENTRYPOINT [ "python" ]
# Incase of local unit-test implementation in the future.  
CMD [ "main.py" ] 

