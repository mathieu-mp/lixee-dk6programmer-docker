#!/bin/bash
set -eu
[ -z "${TRACE-}" ] || set -x

log() {
  echo >&2 "${@}"
}

error() {
  log "ERROR: ${@}"
  return 1
}

prepare_firmware() {
  set -eu
  file="${1}"
  if [ ! -r "${file}" ]; then
    error "Unreadable firmware file '${file}'"
  elif file -b "${file}" | grep -qi ^zip; then
    unzip "${file}" | sed -nE 's/  inflating: (.+)/\1/p'
  else
    echo "${file}"
  fi
}

run() {
  local source="${1}" file
  shift
  if [ -n "${source}" ]; then
    file="$(prepare_firmware "${source}")"
    [ "${file}" = "${source}" ] || log "Firmware source: '${source}'"
    if [ -z "${file}" ]; then
      error "Firmware source does not contain a firmware file."
    elif [ "$(echo "${file}" | wc -l)" -gt 1 ]; then
      error "Expected exactly 1 firmware file, but found: $(echo "${file}" | xargs)"
    else
      log "Firmware file:   '${file}'"
      set -- "${@}" "${file}"
    fi
  fi
  DK6Programmer "${@}"
}

main() {
  local source
  if [ -n "${FIRMWARE_FILE-}" ]; then
    source="${FIRMWARE_FILE}"
  elif [ -n "${FIRMWARE_URL-}" ]; then
    log "Downloading firmware from ${FIRMWARE_URL}"
    source="firmware.bin"
    wget "${FIRMWARE_URL}" -O $source
    [ -n "${source}" ] || error "Download of firmware was not successful."
  else
    log "WARNING: neither FIRMWARE_URL nor FIRMWARE_FILE is set as environment variable."
  fi
  run "${source-}" "${@}"
}

main "${@}"