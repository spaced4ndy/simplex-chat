#!/bin/bash

# Line coverage of the desktop app's Kotlin code with JaCoCo.
#   coverage.sh get <dir>                    download the agent and the command line tool from Maven Central, checked
#                                            against the SHA-1 files published beside them, as <dir>/jacocoagent.jar and
#                                            <dir>/jacococli.jar
#   coverage.sh report <dir> <exec dir> <out dir>
#                                            report <exec dir>/unit.exec (desktopTest) and <exec dir>/app-*.exec (the app)
#                                            as XML and HTML in <out dir>/unit and <out dir>/app, against the classes of
#                                            :common and :desktop and their sources

set -euo pipefail

version=0.8.12
maven=https://repo1.maven.org/maven2/org/jacoco

get() {
  local dir=$1 url
  mkdir -p "$dir"
  for jar in "org.jacoco.agent/$version/org.jacoco.agent-$version-runtime.jar jacocoagent.jar" \
    "org.jacoco.cli/$version/org.jacoco.cli-$version-nodeps.jar jacococli.jar"; do
    read -r url name <<< "$jar"
    curl -fsSL -o "$dir/$name" "$maven/$url"
    echo "$(curl -fsSL "$maven/$url.sha1")  $dir/$name" | sha1sum -c -
  done
}

report() {
  local dir=$1 exec_dir=$2 out=$3 mp=apps/multiplatform kind
  local sources=(--sourcefiles "$mp/common/src/commonMain/kotlin" --sourcefiles "$mp/common/src/desktopMain/kotlin" --sourcefiles "$mp/desktop/src/jvmMain/kotlin")
  local classes=(--classfiles "$mp/common/build/classes/kotlin/desktop/main" --classfiles "$mp/desktop/build/classes/kotlin/jvm/main")
  mkdir -p "$out"
  for kind in unit app; do
    local execs=()
    if [ "$kind" = unit ]; then
      [ -f "$exec_dir/unit.exec" ] && execs=("$exec_dir/unit.exec")
    else
      for f in "$exec_dir"/app-*.exec; do
        [ -f "$f" ] && execs+=("$f")
      done
    fi
    if [ ${#execs[@]} -eq 0 ]; then
      echo "no $kind coverage data"
      continue
    fi
    cp "${execs[@]}" "$out/"
    java -jar "$dir/jacococli.jar" report "${execs[@]}" "${classes[@]}" "${sources[@]}" --name "$kind" \
      --xml "$out/$kind.xml" --html "$out/$kind"
  done
}

case "${1:-}" in
  get) get "$2" ;;
  report) report "$2" "$3" "$4" ;;
  *)
    sed -n '3,/^$/s/^# \{0,1\}//p' "$0"
    exit 1
    ;;
esac
