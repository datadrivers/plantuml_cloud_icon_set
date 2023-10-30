#!/bin/bash
#

PREFIX="$1"
FOLDER="$2"
PUML_NAME="templates/${PREFIX}.puml"

function urlencode() {
  python3 -c "import urllib.parse; print(urllib.parse.quote(\"$1\"))"
}

cat << EOF > $PUML_NAME
!\$ICON_SCALE ?= "3"
!\$ELEMENT_FONT_COLOR ?= "black"

!\$PERSON_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$PERSON_BG_COLOR ?= "lightyellow"
!\$PERSON_BORDER_COLOR ?= "black"

!\$EXTERNAL_PERSON_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$EXTERNAL_PERSON_BG_COLOR ?= %darken(\$PERSON_BG_COLOR, 10)
!\$EXTERNAL_PERSON_BORDER_COLOR ?= "black"

!\$SYSTEM_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$SYSTEM_BG_COLOR ?= "orange"
!\$SYSTEM_BORDER_COLOR ?= "black"

!\$EXTERNAL_SYSTEM_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$EXTERNAL_SYSTEM_BG_COLOR ?= %darken(\$SYSTEM_BG_COLOR, 10)
!\$EXTERNAL_SYSTEM_BORDER_COLOR ?= "black"

!\$CONTAINER_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$CONTAINER_BG_COLOR ?= "lightcoral"
!\$CONTAINER_BORDER_COLOR ?= "black"

!\$EXTERNAL_CONTAINER_FONT_COLOR ?= \$ELEMENT_FONT_COLOR
!\$EXTERNAL_CONTAINER_BG_COLOR ?= %darken(\$CONTAINER_BG_COLOR, 10)
!\$EXTERNAL_CONTAINER_BORDER_COLOR ?= "black"

!\$COMPONENT_FONT_COLOR ?= "#000000"
!\$COMPONENT_BG_COLOR ?= "lightgreen"
!\$COMPONENT_BORDER_COLOR ?= "black"

!\$EXTERNAL_COMPONENT_FONT_COLOR ?= \$COMPONENT_FONT_COLOR
!\$EXTERNAL_COMPONENT_BG_COLOR ?= %darken(\$COMPONENT_BG_COLOR, 10)
!\$EXTERNAL_COMPONENT_BORDER_COLOR ?= "black"

EOF

IFS=$'\n'

echo "| Icon | Variable |" > $PREFIX.md
echo "|-----:|:---------|" >> $PREFIX.md

for svg in $(find $FOLDER -name "*.svg" | sort )
do

  title=${svg/.svg}
  title="${PREFIX}_$(echo "$title" | awk -F'/' '{category=toupper($(NF-1)); name=toupper($NF); if ( category == name ) { print name } else {print category "_" name }}' | tr ' -' '_')"

  if [[ "$1" == "AZURE" ]]
  then
    title=${title/_[0-9][0-9][0-9][0-9][0-9]_ICON_SERVICE}
    title=${title/+_}
    title=$(echo $title | tr -d '()')
  fi

cat << EOF >> $PUML_NAME
!function \$$title(\$scale="3.0")
  !\$img = "img:data:image/svg+xml;base64,$(base64 -i "$svg")"
  !return \$img + "{scale=" + \$scale + "}"
!endfunction

EOF

  echo -e "| ![\$${title}()]($(urlencode $svg)) | \\\$${title}() |"

done | tee -a $PREFIX.md
