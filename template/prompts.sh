#!/bin/bash

echo "What is your name?"
read name

echo "Hello, $name! What would you like to do? "
options=("Create a new project" "Go on an adventure" "Hear interesting facts about Texas")
select activity in "${options[@]}"
do
    case $activity in
        "Create a new project")
            break
            ;;
        "Go on an adventure")
            break
            ;;
        "Hear interesting facts about Texas")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "$name wants to $(echo $activity | tr '[:upper:]' '[:lower:]')."
