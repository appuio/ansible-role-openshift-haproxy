#!/bin/bash

shopt -s nullglob

ORIG_TEMPLATE_FILE=/var/lib/haproxy/conf/haproxy-config.template

if [ "${PRESTART_DIR}" ] && [ "${TEMPLATE_FILE}" ] && [ ! "${TEMPLATE_FILE}" -ef "${ORIG_TEMPLATE_FILE}" ]; then
  cp "${ORIG_TEMPLATE_FILE}" "${TEMPLATE_FILE}"

  for script in ${PRESTART_DIR}/*; do
    $script "${TEMPLATE_FILE}"
  done
else
  echo "Warning: TEMPLATE_FILE or PRESTART_DIR undefined, skipping prestart scripts!" >&2
fi

exec "$@"
