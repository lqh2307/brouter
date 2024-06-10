#!/bin/bash

JAVA='java -Xmx2600m -Xms2600m -Xmn32m'

rm -rf ${SEGMENTSPATH}/*
mkdir -p \
  tmp \
  tmp/nodetiles \
  tmp/waytiles \
  tmp/waytiles55 \
  tmp/nodes55 \
  tmp/unodes55

${JAVA} \
  -cp /brouter.jar \
  -DavoidMapPolling=true \
  -Ddeletetmpfiles=false \
  -DuseDenseMaps=true \
  btools.mapcreator.OsmFastCutter \
  ${PROFILESPATH}/lookups.dat \
  tmp/nodetiles \
  tmp/waytiles \
  tmp/nodes55 \
  tmp/waytiles55 \
  tmp/bordernids.dat \
  tmp/relations.dat \
  tmp/restrictions.dat \
  ${PROFILESPATH}/all.brf \
  ${PROFILESPATH}/trekking.brf \
  ${PROFILESPATH}/softaccess.brf \
  ${OSM_PBF_FILE}

${JAVA} \
  -cp /brouter.jar \
  -Ddeletetmpfiles=true \
  -DuseDenseMaps=true \
  btools.mapcreator.PosUnifier \
  tmp/nodes55 \
  tmp/unodes55 \
  tmp/bordernids.dat \
  tmp/bordernodes.dat \
  ${SRTM_PATH}

${JAVA} \
  -cp /brouter.jar \
  -DuseDenseMaps=true \
  -DskipEncodingCheck=true \
  btools.mapcreator.WayLinker \
  tmp/unodes55 \
  tmp/waytiles55 \
  tmp/bordernodes.dat \
  tmp/restrictions.dat \
  ${PROFILESPATH}/lookups.dat \
  ${PROFILESPATH}/all.brf \
  ${SEGMENTSPATH} \
  rd5

rm -rf tmp
