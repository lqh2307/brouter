#!/bin/sh

JAVA_OPTS="-Xmx128M -Xms128M -Xmn8M"
 
export SEGMENTSPATH=/segments4
export PROFILESPATH=/profiles2
export CUSTOMPROFILESPATH=/customprofiles

if [ -n "${OSM_PBF_FILE}" ]; then
  /bin/process_osm_pbf.sh
fi

java ${JAVA_OPTS} -cp /brouter.jar btools.server.RouteServer ${SEGMENTSPATH} ${PROFILESPATH} ${CUSTOMPROFILESPATH} 17777 1
