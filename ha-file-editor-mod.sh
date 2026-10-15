# DJ: MODIFY File Editor app CSS to reduce wasted space in the file/folder list
# https://github.com/DJF3/Home-Assistant-File-editor-UI-modifications
# REQUIREMENT: Turn OFF protection mode in "Advanced SSH & Web Terminal" app
# NOTE: You can run this multiple times, it will only modify once.
# REVERT BACK? see Github instructions 

#!/usr/bin/env bash

CONTAINER=$(docker ps --format "{{.Names}}" | grep core_configurator)

docker exec -i "$CONTAINER" /bin/bash << 'OUTER'
CSS="/usr/lib/python3.14/site-packages/hass_configurator/style.css"
cp -n "$CSS" "$CSS.bak"
sed -i '/BEGIN_CUSTOM_OVERRIDES/,/END_CUSTOM_OVERRIDES/d' "$CSS"
cat >> "$CSS" << 'CSSBLOCK'

/* BEGIN_CUSTOM_OVERRIDES */
:root {
  --dj-file-yaml: blue;
  --dj-file-name: #000;
  --dj-row-bg: #fff;
}

@media (prefers-color-scheme: dark) {
  :root {
    --dj-file-yaml: blue; 
    --dj-file-name: #000;
    --dj-row-bg: #222;
  }
}

.fbicon_pad {
  min-height: 32px !important;
}

.fb_side-nav li {
  line-height: 24px !important;
}

.fbmenuicon_pad {
  margin-top: 0px !important;
}

.side-nav li > a {
  height: 28px !important;
  line-height: 28px !important;
}

/* files using XML/YAML-ish icon */

/* optional: normal filenames */
.side-nav li a .filename {
  color: var(--dj-file-name) !important;
}

.side-nav li a i.mdi-file-xml + div.filename {
  color: var(--dj-file-yaml) !important;
  /* font-weight: bold !important; */
}

/* END_CUSTOM_OVERRIDES */
CSSBLOCK
OUTER

echo "       --Finished--"