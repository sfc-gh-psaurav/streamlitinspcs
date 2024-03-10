FROM python:3.8-slim

RUN apt-get update && apt install gcc git -y 

RUN addgroup --gid 3000 --system appgroup \
    && adduser --uid 3000 --ingroup appgroup appuser


ENV PATH="/home/appuser/.local/bin:${PATH}"

WORKDIR /app
COPY --chown=3000:3000 . /app

USER 3000:3000
RUN pip install --user --no-cache-dir oscrypto@git+https://github.com/wbond/oscrypto.git@d5f3437ed24257895ae1edd9e503cfb352e635a8
RUN pip3 install --user --no-cache-dir -r requirements.txt
# RUN python -m spacy download en_core_web_sm
RUN pip3 install --user --no-cache-dir ddtrace 

ARG environment
ENV DD_ENV $environment
ENV DD_REMOTE_CONFIGURATION_ENABLED=true
ENV DD_SERVICE "snowpulse"
ENV DD_LOGS_INJECTION=true

EXPOSE 8501

ENV STREAMLIT_DIR_PATH="/home/appuser/.local/lib/python3.8/site-packages/streamlit/static/static/js"
RUN find ${STREAMLIT_DIR_PATH} -type f -name "main.*.js" -print0 | xargs -0 sed -i -e 's/,1e3/,1e4/g' -e 's/baseUriPartsList,500/baseUriPartsList,10000/g'

CMD ["ddtrace-run", "streamlit", "run", "app.py"]