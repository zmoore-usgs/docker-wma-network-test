FROM cidasdpdasartip.cr.usgs.gov:8447/wma/wma-spring-boot-base:latest

ARG ARTIFACT_URL="https://cida.usgs.gov/wsos2314/test1/10MB.dat"

LABEL maintaner="gs-w_eto@usgs.gov"

COPY --chown=1000:1000 pull-test-file.sh /home/$USER/pull-test-file.sh
COPY --chown=1000:1000 launch-app.sh /home/$USER/launch-app.sh
RUN chmod +x /home/$USER/pull-test-file.sh
RUN chmod +x /home/$USER/launch-app.sh

RUN ./pull-test-file.sh $ARTIFACT_URL