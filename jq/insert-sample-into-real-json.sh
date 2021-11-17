# Author:      Zachary Watkins, z-watkins@tti.tamu.edu
#              Texas A&M Transportation Institute
# Commands:    grep, cut, tr, echo, curl
# Environment: Mac OSX Bash Shell

env_file=".env.local"

#===============================================================
# DO NOT EDIT BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING
#===============================================================

env_website="JSON_FEED_WEBSITE"
env_feed_src="JSON_FEED_SRC"
env_feed_dest="JSON_FEED_DEST"

# Convert lines in file env_file to variables
json_url=$(grep $env_feed_src $env_file | cut -d '=' -f2 | tr -d '"')
json_dest=$(grep $env_feed_dest $env_file | cut -d '=' -f2 | tr -d '"')
origin=$(grep $env_website $env_file | cut -d '=' -f2 | tr -d '"')
json_dest_asset="${json_dest/dist/public}"


# Remove comments on next 2 lines if you want to add a timestamp
# at the end of the JSON filename. Such a file WILL NOT SHOW on
# the web page as the application does not detect that file name
# structure.
# now_with_seconds=$(date +"%Y-%m-%d-%Hh-%Mm-%Ss")
# json_dest="${json_dest/.json/-${now_with_seconds}.json}"

curl $json_url \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: "Google Chrome";v="95", "Chromium";v="95", ";Not A Brand";v="99"' \
  -H 'Accept: application/json' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  -H "Origin: $origin" \
  -H 'Sec-Fetch-Site: cross-site' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H "Referer: $origin" \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'If-Modified-Since: Tue, 16 Nov 2021 15:04:06 GMT' \
  | jq '.' | tee $json_dest > $json_dest_asset
  
# Provide additional sample data for testing purposes.
# For expedited testing we are only going to provide a specific and non-specific subtype per type.
# Import sample event.
sample_event=($(jq -r '.alerts[0]' $json_dest))
counter=0
alert_types=(
  "ACCIDENT",
  "JAM",
  "WEATHERHAZARD",
  "HAZARD",
  "MISC",
  "CONSTRUCTION",
  "ROAD_CLOSED"
)
accident=(
  "ACCIDENT_MINOR",
  "ACCIDENT_MAJOR",
  "NO_SUBTYPE"
)
jam=(
  "JAM_MODERATE_TRAFFIC",
  "JAM_HEAVY_TRAFFIC",
  "JAM_STAND_STILL_TRAFFIC",
  "JAM_LIGHT_TRAFFIC",
  "NO_SUBTYPE"
)
weather_hazard=(
  "HAZARD_WEATHER",
  "HAZARD_WEATHER_FOG",
  "HAZARD_WEATHER_HAIL",
  "HAZARD_WEATHER_HEAVY_RAIN",
  "HAZARD_WEATHER_HEAVY_SNOW",
  "HAZARD_WEATHER_FLOOD",
  "HAZARD_WEATHER_MONSOON",
  "HAZARD_WEATHER_TORNADO",
  "HAZARD_WEATHER_HEAT_WAVE",
  "HAZARD_WEATHER_HURRICANE",
  "HAZARD_WEATHER_FREEZING_RAIN",
  "HAZARD_ON_ROAD_ICE"
)
hazard=(
  "HAZARD_ON_ROAD",
  "HAZARD_ON_SHOULDER",
  "HAZARD_ON_ROAD_OBJECT",
  "HAZARD_ON_ROAD_POT_HOLE",
  "HAZARD_ON_ROAD_ROAD_KILL",
  "HAZARD_ON_SHOULDER_CAR_STOPPED",
  "HAZARD_ON_SHOULDER_ANIMALS",
  "HAZARD_ON_SHOULDER_MISSING_SIGN",
  "HAZARD_ON_ROAD_LANE_CLOSED",
  "HAZARD_ON_ROAD_OIL",
  "HAZARD_ON_ROAD_CONSTRUCTION",
  "HAZARD_ON_ROAD_CAR_STOPPED",
  "HAZARD_ON_ROAD_TRAFFIC_LIGHT_FAULT",
  "NO_SUBTYPE"
)
misc=(
  "NO_SUBTYPE"
)
construction=(
  "NO_SUBTYPE"
)
road_closed=(
  "ROAD_CLOSED_HAZARD",
  "ROAD_CLOSED_CONSTRUCTION",
  "ROAD_CLOSED_EVENT",
  "NO_SUBTYPE"
)
for alert_type in ${alert_types[@]}; do
  # Determine which type is being processed in this loop.
  # Then assign that type's subtypes to a list variable.
  subtype_list=()
  if [ "$alert_type" = "ACCIDENT" ]; then
    subtype_list=$accident
    continue
  elif [ "$alert_type" = "JAM" ]; then
    subtype_list=$jam
    continue
  elif [ "$alert_type" = "WEATHERHAZARD" ]; then
    subtype_list=$weather_hazard
    continue
  elif [ "$alert_type" = "HAZARD" ]; then
    subtype_list=$hazard
    continue
  elif [ "$alert_type" = "CONSTRUCTION" ]; then
    subtype_list=$construction
    continue
  elif [ "$alert_type" = "ROAD_CLOSED" ]; then
    subtype_list=$road_closed
    continue
  else
    subtype_list=$misc
  fi;
  jq '.alerts[$count]'
  $count++
done
