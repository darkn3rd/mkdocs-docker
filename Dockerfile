FROM python:3.7.2
RUN pip install --upgrade pip
ENV APPDIR /opt/app
ENV DOCDIR /opt/docs
RUN mkdir -p ${APPDIR} ${DOCDIR}

# Install Components
ADD requirements.txt ${APPDIR}/
RUN pip install -r ${APPDIR}/requirements.txt

# Install Custom Scripts
ADD . ${APPDIR}/
RUN ln -s ${APPDIR}/serve /usr/local/bin/serve
RUN ln -s ${APPDIR}/produce /usr/local/bin/produce

# Working Directory documentation dir mount
VOLUME ${DOCDIR}
WORKDIR ${DOCDIR}

EXPOSE 8000