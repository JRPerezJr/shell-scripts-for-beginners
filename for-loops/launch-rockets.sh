# Version 1
for mission in lunar-mission mars-mission jupiter-mission saturn-mission mercury-mission; do
    bash create-and-launch-rocket $mission
done

# Version 2

for mission in $(cat /tmp/assets/mission-names.txt); do
    bash create-and-launch-rocket $mission
done