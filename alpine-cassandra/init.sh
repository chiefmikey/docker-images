#!/bin/bash

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
  touch $CONTAINER_ALREADY_STARTED
  echo "-- First container startup --"
  # Set user
  set -eux; \
    addgroup -S ${CASSANDRA_USER} && adduser -S -D -G ${CASSANDRA_USER} ${CASSANDRA_USER}
  # Install dependencies
  set -eux; \
    apk update && apk upgrade
    apk add --no-cache \
      sudo \
      openjdk11-jre \
      openssl \
      libc6-compat \
      libuuid \
      procps \
      iproute2 \
      numactl \
      python3 \
      ca-certificates \
      gnupg \
      dpkg \
      wget
  # Install gosu
  set -eux; \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
    gpgconf --kill all; \
    rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
    chmod +x /usr/local/bin/gosu; \
    gosu --version; \
    gosu nobody true
  # Set keys
  export GPG_KEYS="\
    CEC86BB4A0BA9D0F90397CAEF8358FA2F2833C93 \
    C4965EE9E3015D192CCCF2B6F758CE318D77295D \
    5AED1BF378E9A19DADE1BCB34BD736A82B5C1B00 \
    514A2AD631A57A16DD0047EC749D6EEC0353B12C \
    A26E528B271F19B9E5D8E19EA278B781FE4B2BDA \
    A4C465FEA0C552561A392A61E91335D77E3E87CB \
    9E66CEC6106D578D0B1EB9BFF1000962B7F6840C \
    C4009872C59B49561310D966D0062876AF30F054 \
    B7842CDAF36E6A3214FAE35D5E85B9AE0B84C041 \
    3E9C876907A560ACA00964F363E9BAD215BBF5F0"
  export CASSANDRA_SHA512=94e923963531b97dbfcf90eb95e423abd9990fae02d1c9a90bf2d76ceb6cd9e422db628b9ec3a45994b3654f1f562f5df84718064722004ae8ba5b5abb11d0b6
  # Install cassandra
  set -eux; \
    ddist() { \
      local f="$1"; shift; \
      local distFile="$1"; shift; \
      local success=; \
      local distUrl=; \
      for distUrl in 'https://www.apache.org/dyn/closer.cgi?action=download&filename=' https://www-us.apache.org/dist/ https://www.apache.org/dist/ https://archive.apache.org/dist/; do \
        if wget --progress=dot:giga -O "$f" "$distUrl$distFile" && [ -s "$f" ]; then \
          success=1; \
          break; \
        fi; \
      done; \
      [ -n "$success" ]; \
    }; \
    ddist 'cassandra-bin.tgz' "cassandra/$CASSANDRA_VERSION/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz"; \
    echo "$CASSANDRA_SHA512 *cassandra-bin.tgz" | sha512sum -cs -; \
    ddist 'cassandra-bin.tgz.asc' "cassandra/$CASSANDRA_VERSION/apache-cassandra-$CASSANDRA_VERSION-bin.tar.gz.asc"; \
    export GNUPGHOME="$(mktemp -d)"; \
    for key in $GPG_KEYS; do \
      gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$key"; \
    done; \
    gpg --batch --verify cassandra-bin.tgz.asc cassandra-bin.tgz; \
    rm -rf "$GNUPGHOME"; \
    mkdir -p "$CASSANDRA_HOME"; \
    tar --extract --file cassandra-bin.tgz --directory "$CASSANDRA_HOME" --strip-components 1; \
    rm cassandra-bin.tgz*; \
    [ ! -e "$CASSANDRA_CONF" ]; \
    mv "$CASSANDRA_HOME/conf" "$CASSANDRA_CONF"; \
    ln -sT "$CASSANDRA_CONF" "$CASSANDRA_HOME/conf"; \
    dpkgArch="$(dpkg --print-architecture)"; \
    case "$dpkgArch" in \
      ppc64el) \
        # https://issues.apache.org/jira/browse/CASSANDRA-13345
        # "The stack size specified is too small, Specify at least 328k"
        if grep -q -- '^-Xss' "$CASSANDRA_CONF/jvm.options"; then \
           # 3.11+ (jvm.options)
          grep -- '^-Xss256k$' "$CASSANDRA_CONF/jvm.options"; \
          sed -ri 's/^-Xss256k$/-Xss512k/' "$CASSANDRA_CONF/jvm.options"; \
          grep -- '^-Xss512k$' "$CASSANDRA_CONF/jvm.options"; \
        elif grep -q -- '-Xss256k' "$CASSANDRA_CONF/cassandra-env.sh"; then \
          # 3.0 (cassandra-env.sh)
          sed -ri 's/-Xss256k/-Xss512k/g' "$CASSANDRA_CONF/cassandra-env.sh"; \
          grep -- '-Xss512k' "$CASSANDRA_CONF/cassandra-env.sh"; \
        fi; \
    esac; \
    mkdir -p "$CASSANDRA_CONF" /var/lib/cassandra /var/log/cassandra; \
    chown -R cassandra:cassandra "$CASSANDRA_CONF" /var/lib/cassandra /var/log/cassandra; \
    chmod 777 "$CASSANDRA_CONF" /var/lib/cassandra /var/log/cassandra; \
    chmod -R a+rwX "$CASSANDRA_CONF"; \
    ln -sT /var/lib/cassandra "$CASSANDRA_HOME/data"; \
    ln -sT /var/log/cassandra "$CASSANDRA_HOME/logs"; \
  # Set variable
  export cassandra=$CASSANDRA_HOME/bin/cassandra
  # Start cassandra
  set -e
  # first arg is `-f` or `--some-option`
  # or there are no args
  if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- "$cassandra" -f "$@"
  fi
  # allow the container to be started with `--user`
  if [ "$1" = "$cassandra" -a "$(id -u)" = '0' ]; then
    find "$CASSANDRA_CONF" /var/lib/cassandra /var/log/cassandra ! -user cassandra -exec chown cassandra '{}' +
    # exec gosu cassandra "$BASH_SOURCE" "$@"
  fi
  # scrape the first non-localhost IP address of the container
  _ip_address() {
    # in Swarm Mode, we often get two IPs -- the container IP, and the (shared) VIP, and the container IP should always be first
    ip address | awk '
      $1 != "inet" { next } # only lines with ip addresses
      $NF == "lo" { next } # skip loopback devices
      $2 ~ /^127[.]/ { next } # skip loopback addresses
      $2 ~ /^169[.]254[.]/ { next } # skip link-local addresses
      {
        gsub(/\/.+$/, "", $2)
        print $2
        exit
      }
    '
  }

  # "sed -i", but without "mv" (which doesn't work on a bind-mounted file, for example)
  _sed_in_place() {
    local filename="$1"; shift
    local tempFile
    tempFile="$(mktemp)"
    sed "$@" "$filename" > "$tempFile"
    cat "$tempFile" > "$filename"
    rm "$tempFile"
  }

  if [ "$1" = "$cassandra" ]; then
    : ${CASSANDRA_RPC_ADDRESS='0.0.0.0'}

    : ${CASSANDRA_LISTEN_ADDRESS='auto'}
    if [ "$CASSANDRA_LISTEN_ADDRESS" = 'auto' ]; then
      CASSANDRA_LISTEN_ADDRESS="$(_ip_address)"
    fi

    : ${CASSANDRA_BROADCAST_ADDRESS="$CASSANDRA_LISTEN_ADDRESS"}

    if [ "$CASSANDRA_BROADCAST_ADDRESS" = 'auto' ]; then
      CASSANDRA_BROADCAST_ADDRESS="$(_ip_address)"
    fi
    : ${CASSANDRA_BROADCAST_RPC_ADDRESS:=$CASSANDRA_BROADCAST_ADDRESS}

    if [ -n "${CASSANDRA_NAME:+1}" ]; then
      : ${CASSANDRA_SEEDS:="$cassandra"}
    fi
    : ${CASSANDRA_SEEDS:="$CASSANDRA_BROADCAST_ADDRESS"}

    _sed_in_place "$CASSANDRA_CONF/cassandra.yaml" \
      -r 's/(- seeds:).*/\1 "'"$CASSANDRA_SEEDS"'"/'

    for yaml in broadcast_address broadcast_rpc_address cluster_name endpoint_snitch listen_address num_tokens rpc_address start_rpc; do
      var="CASSANDRA_${yaml^^}"
      val="${!var+x}"
      if [ "$val" = x ]; then
        val="${!var}"
      fi
      if [ "$val" ]; then
        _sed_in_place "$CASSANDRA_CONF/cassandra.yaml" \
          -r 's/^(# )?('"$yaml"':).*/\2 '"$val"'/'
      fi
    done

    for rackdc in dc rack; do
      var="CASSANDRA_${rackdc^^}"
      val="${!var+x}"
      if [ "$val" = x ]; then
        val="${!var}"
      fi
      if [ "$val" ]; then
        _sed_in_place "$CASSANDRA_CONF/cassandra-rackdc.properties" \
          -r 's/^('"$rackdc"'=).*/\1 '"$val"'/'
      fi
    done
  fi
  # Start cassandra
  exec gosu cassandra "$BASH_SOURCE" "$@"
else
  echo "-- Not first container startup --"
  # Start cassandra
  exec gosu cassandra "$BASH_SOURCE" "$@"
fi
